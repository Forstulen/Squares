//
//  SquareGameViewController.h
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import <UIKit/UIKit.h>
#import "SquareGameOverViewController.h"
#import "SquareLevels.h"
#import "SquareBase.h"
#import "SquareGrid.h"

@class  SquareParticlesEmitter;

@interface SquareGameViewController : UIViewController <SquareGameOvertDelegate> {
    SquareGrid      *_squareGrid;
    SquareGameType  _squareGameType;
    SquareGameOverViewController *_squareGameOverViewController;
    SquareParticlesEmitter  *_squareParticlesEmitter;
    
    CADisplayLink   *_squareGameLoop;
    BOOL            _squareGridEnabled;
    
    CFTimeInterval  _squareElapsedTime;
    CFTimeInterval  _squareLastSpawnTime;
    CFTimeInterval  _squareLastActivityTime;
    CFTimeInterval  _squareLastLevelTime;
    CFTimeInterval  _squareLastRefreshTime;
    CFTimeInterval  _squarePauseTime;
    CFTimeInterval  _squareLastBackGroundLinesTime;
    
    CGPoint         _squareLastPositionKnow;
}

- (void)configureGameMode:(SquareGameType)type;
- (void)restartGame;
- (void)quitGame;

@property (weak, nonatomic) IBOutlet UIView *GameBoard;
@property (weak, nonatomic) IBOutlet UILabel *Score;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *squareMultiplier;
@property (weak, nonatomic) IBOutlet UILabel *squarePauseLabel;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *squarePauseButton;

@end
