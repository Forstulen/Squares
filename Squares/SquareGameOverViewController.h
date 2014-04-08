//
//  SquareGameOverViewController.h
//  Squares
//
//  Created by Romain on 4/6/14.
//
//

#import <UIKit/UIKit.h>

@protocol SquareGameOvertDelegate <NSObject>
- (void)restartGame;
- (void)quitGame;
@end

@interface SquareGameOverViewController : UIViewController

- (void)presentAnimatedGameOverView:(UIView *)parent withCompletion:(void (^)(BOOL))block;
- (void)dismissAnimatedGameOverView:(UIView *)parent withCompletion:(void (^)(BOOL))block;

@property (strong, nonatomic) id<SquareGameOvertDelegate> squareGameOverViewDelegate;
@property (weak, nonatomic) IBOutlet UILabel *squareScore;

@end
