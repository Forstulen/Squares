//
//  SquareSocialController.m
//  Squares
//
//  Created by Romain on 4/10/14.
//
//

#import "SquareSocialController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "defines.h"

@interface SquareSocialController ()

- (id)init;

@end


@implementation SquareSocialController

+ (SquareSocialController *)sharedSquareSocialController {
    static SquareSocialController *socialController = nil;
    @synchronized(self) {
        if (socialController == nil) {
            socialController = [[self alloc] init];
        }
    }
    return socialController;
}

- (id)init {
    if (self = [super init]) {
        _squareAccountStore = [[ACAccountStore alloc] init];
        _squareAccountType = [_squareAccountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    }
    return self;
}

- (void)presentSimpleAlertViewWithMessage:(NSString *)mess {
    UIAlertView *alert = [[UIAlertView alloc] init];
    
	alert.title = @"SQUARES";
	alert.message = mess;
	alert.cancelButtonIndex = [alert addButtonWithTitle:@"Ok"];

    // Alert must be shown with the main thread in iOS6.0
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}

- (NSDictionary *)getReadFacebookOptions {
    NSDictionary *options = @{
                              ACFacebookAppIdKey:SQUARE_FACEBOOK_ID,
                              ACFacebookPermissionsKey: @[@"email"],
                              ACFacebookAudienceKey: ACFacebookAudienceFriends
                              };
    
    return options;
}


- (NSDictionary *)getPublishFacebookOptions {
    NSDictionary *options = @{
                              ACFacebookAppIdKey:SQUARE_FACEBOOK_ID,
                              ACFacebookPermissionsKey: @[@"email", @"publish_actions"],
                              ACFacebookAudienceKey: ACFacebookAudienceFriends
                              };
    
    return options;
}

- (void)requestAccessToFacebookAccountWithCompletionHandler:(FacebookCompletionBlock)completionHandler {
    if (_squareFacebookAccount != nil) {
        completionHandler(YES);
    } else {
        [_squareAccountStore requestAccessToAccountsWithType:_squareAccountType options:[self getReadFacebookOptions] completion:^(BOOL accessForReadingGranted, NSError *error) {
            if (accessForReadingGranted) {
                [_squareAccountStore requestAccessToAccountsWithType:_squareAccountType options:[self getPublishFacebookOptions] completion:^(BOOL accessForWrittingGranted, NSError *error) {
                    if (accessForWrittingGranted) {
                        completionHandler(YES);
                    } else {
                        completionHandler(NO);
                    }
                }];
            } else {
                completionHandler(NO);
            }
        }];
    }
}

- (void)createMessage:(SquareGameType)game withScore:(NSUInteger)score {
    NSDictionary    *parameters;
     NSURL *feedURL = [NSURL URLWithString:@"https://graph.facebook.com/me/feed"];
    
    if (game == SquareLevelsPlay) {
        parameters = @{@"message": [NSString stringWithFormat:@"SQUARES/nTraining mode %lu", (unsigned long)score]};
    } else {
        parameters = @{@"message": [NSString stringWithFormat:@"SQUARES/nHardcore mode %lu", (unsigned long)score]};
    }
    
    SLRequest *feedRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                                requestMethod:SLRequestMethodPOST
                                                          URL:feedURL
                                                   parameters:parameters];
    
    feedRequest.account = _squareFacebookAccount;
    [feedRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSString    *output;
        if (self.squareDelegate)
            [self.squareDelegate stopRequest];
        
        if(error == nil) {
            output = @"Your score is now on Facebook";
        } else {
            output = @"An error has occured with Facebook";
        }
        [self performSelectorOnMainThread:@selector(presentSimpleAlertViewWithMessage:) withObject:output waitUntilDone:NO];
    }];
}

- (void)handleFacebookError {
    NSArray *facebookAccounts = [_squareAccountStore accountsWithAccountType:_squareAccountType];
    
    if (self.squareDelegate)
        [self.squareDelegate stopRequest];
    
    if(facebookAccounts != nil && [facebookAccounts count] == 0) {
        [self presentSimpleAlertViewWithMessage:@"There are no Facebook accounts configured. You can add or create a Facebook account in Settings."];
    } else {
        [self presentSimpleAlertViewWithMessage:@"An error has occured with Facebook"];
    }
}

- (void)postOnFacebook:(SquareGameType)game withScore:(NSUInteger)score {
    if (self.squareDelegate)
        [self.squareDelegate startRequest];
    
    [self requestAccessToFacebookAccountWithCompletionHandler:^(BOOL valid) {
        if (!valid) {
            [self handleFacebookError];
        } else {
            _squareFacebookAccount = [[_squareAccountStore accountsWithAccountType:_squareAccountType] lastObject];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self createMessage:game withScore:score];
            });

        }
    }];
}

@end
