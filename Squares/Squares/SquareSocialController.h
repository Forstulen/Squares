//
//  SquareSocialController.h
//  Squares
//
//  Created by Romain on 4/10/14.
//
//

#import <Foundation/Foundation.h>
#import "SquareLevels.h"

@class ACAccount;
@class ACAccountStore;
@class ACAccountType;

@protocol SquareSocialDelegate <NSObject>
- (void)startRequest;
- (void)stopRequest;
@end

typedef void (^FacebookCompletionBlock) (BOOL valid);


@interface SquareSocialController : NSObject {
    __block ACAccount *_squareFacebookAccount;
    ACAccountStore  *_squareAccountStore;
    ACAccountType   *_squareAccountType;
}

+ (SquareSocialController *)sharedSquareSocialController;

- (void)postOnFacebook:(SquareGameType)game withScore:(NSUInteger)score;

@property (strong, nonatomic) id<SquareSocialDelegate>    squareDelegate;

@end
