//
//  SquareGameViewController.h
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import <UIKit/UIKit.h>
#import "SquareGameOverViewController.h"
#import "SquareBase.h"
#import "SquareGrid.h"

@interface SquareGameViewController : UIViewController <SquareGameOvertDelegate, SquareGridDelegate> {
    SquareGrid      *_squareGrid;
    SquareGameOverViewController *_squareGameOverViewController;
    CFTimeInterval  _squareSavedTime;
    CADisplayLink   *_squareGameLoop;
    BOOL            _squareGridEnabled;
    
    NSUInteger      _squareScore;
    NSUInteger      _squareBonusMultiplier;
    NSUInteger      _squareColorChain;
    SquareBaseColor _squareLastColor;
    
}

- (void)addSquare;
- (void)generateSquare;
- (void)activateSquareAction:(CGPoint)point;
- (void)checkCollisions;
- (void)restartGame;
- (void)quitGame;
- (void)gameOver;

@property (weak, nonatomic) IBOutlet UIView *GameBoard;
@property (weak, nonatomic) IBOutlet UILabel *Score;
@property (strong, nonatomic) IBOutlet UIView *view;

@end
