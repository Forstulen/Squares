//
//  SquareGameOver.m
//  Squares
//
//  Created by Romain on 4/7/14.
//
//

#import "UIImage+UIImageAdditions.h"
#import "SquareGameOver.h"
#import "SquareGrid.h"
#import "defines.h"

@implementation SquareGameOver

+ (SquareBase*)squareGameOverWithPosition:(CGPoint)point withGrid:(SquareGrid *)grid {
    return[[SquareGameOver alloc] initWithPoint:point withGrid:grid];
}

- (id)initWithPoint:(CGPoint)point withGrid:(SquareGrid *)grid {
    if (self = [super initWithFrame:CGRectMake(point.x, point.y, SQUARE_GAMEOVER_STARTING_SIZE, SQUARE_GAMEOVER_STARTING_SIZE)]) {
        _squareGrid = grid;
        
        self.squareColor = [self getRandomColor];
        self.squareScalingDuration = SQUARE_GAMEOVER_DURATION;
        self.squareScalingDelay = SQUARE_GAMEOVER_DELAY;
        self.squareScore = SQUARE_GAMEOVER_SCORE;
        self.squareTouches = SQUARE_GAMEOVER_TOUCHES_NUMBER;
        self.image = [UIImage imageNamed:SQUARE_IMAGE_GAMEOVER withColor:[self getUIColor:self.squareColor]];
    }
    return self;
}

- (void)beginAnimation {
    [UIView animateWithDuration:self.squareScalingDuration
                          delay: self.squareScalingDelay
                        options: UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear
     
                     animations: ^{
                         CATransform3D layerTransform = CATransform3DMakeScale(SQUARE_GAMEOVER_ENDING_SIZE / SQUARE_GAMEOVER_STARTING_SIZE, SQUARE_GAMEOVER_ENDING_SIZE / SQUARE_GAMEOVER_STARTING_SIZE, 1.0);
                         
                         self.layer.transform = layerTransform;
                     }
     
                     completion:^(BOOL finished) {
                         self.image = nil;
                         [_squareGrid removeSquare:self];
                         [self.layer removeAllAnimations];
                         [self removeFromSuperview];
                     }];
}

@end
