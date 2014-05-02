//
//  SquareGameOverViewController.h
//  Squares
//
//  Created by Romain on 4/6/14.
//
//

#import <UIKit/UIKit.h>
#import "SquareSocialController.h"

@protocol SquareGameOverDelegate <NSObject>
- (void)restartGame;
- (void)quitGame;
@end

@interface SquareGameOverViewController : UIViewController <SquareSocialDelegate>{
    UIActivityIndicatorView     *_squareActivityIndicator;
}

- (void)presentAnimatedGameOverView:(UIView *)parent withCompletion:(void (^)(BOOL))block;
- (void)dismissAnimatedGameOverView:(UIView *)parent withCompletion:(void (^)(BOOL))block;

@property (strong, nonatomic) id<SquareGameOverDelegate> squareGameOverViewDelegate;

@property (weak, nonatomic) IBOutlet UILabel *squareTitle;
@property (weak, nonatomic) IBOutlet UILabel *squareScore;
@property (weak, nonatomic) IBOutlet UILabel *squareBestScoreTitle;
@property (weak, nonatomic) IBOutlet UILabel *squareBestScore;

@property (weak, nonatomic) IBOutlet UIButton *squareFacebookButton;
@property (weak, nonatomic) IBOutlet UIButton *squareTryAgainButton;
@property (weak, nonatomic) IBOutlet UIButton *squareQuitButton;

@end
