//
//  SquareSocialController.h
//  Squares
//
//  Created by Romain on 4/10/14.
//
//

#import <Foundation/Foundation.h>
#import "SquareGameViewController.h"

@class ACAccount;
@class ACAccountStore;
@class ACAccountType;

typedef void (^FacebookCompletionBlock) (BOOL valid);

@interface SquareSocialController : NSObject {
    __block ACAccount *_squareFacebookAccount;
    ACAccountStore  *_squareAccountStore;
    ACAccountType   *_squareAccountType;
}

+ (SquareSocialController *)sharedSquareSocialController;

- (void)postOnFacebook:(SquareGameType)game withScore:(NSUInteger)score;

@end
