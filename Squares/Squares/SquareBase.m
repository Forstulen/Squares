//
//  SquareBase.m
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import "UIImage+UIImageAdditions.h"
#import "SquareBase.h"
#import "SquareGrid.h"
#import "defines.h"

NSString * const squareColorArray[] = {
    @"Blue",
    @"Red",
    @"Yellow",
    @"Green"
};

@implementation SquareBase

+ (SquareBase*)squareBaseWithPosition:(CGPoint)point withGrid:(SquareGrid *)grid {
    return[[SquareBase alloc] initWithPoint:point withGrid:grid];
}

+ (NSString*)squareColorEnumToString:(SquareBaseColor)enumVal
{
    return squareColorArray[enumVal];
}

+ (SquareBaseColor)squareColorStringToEnum:(NSString*)strVal
{
    int retVal;
    for(int i = 0; i < sizeof(squareColorArray) - 1; i++)
    {
        if([(NSString*)squareColorArray[i] isEqual:strVal])
        {
            retVal = i;
            break;
        }
    }
    return (SquareBaseColor)retVal;
}

- (id)initWithPoint:(CGPoint)point withGrid:(SquareGrid *)grid {
    if (self = [super initWithFrame:CGRectMake(point.x, point.y, SQUARE_BASE_STARTING_SIZE, SQUARE_BASE_STARTING_SIZE)]) {
        _squareGrid = grid;
        
        self.squareColor = [self getRandomColor];
        self.squareScalingDuration = SQUARE_BASE_DURATION;
        self.squareScalingDelay = SQUARE_BASE_DELAY;
        self.squareScore = SQUARE_BASE_SCORE;
        self.squareTouches = SQUARE_BASE_TOUCHES_NUMBER;
        self.image = [UIImage imageNamed:SQUARE_IMAGE_BASE withColor:[self getUIColor:self.squareColor]];
    }
    return self;
}

- (UIColor *)getUIColor:(SquareBaseColor)color {
    switch (color) {
        case SquareBaseBlue:
            return SQUARE_COLOR_BLUE;
        case SquareBaseGreen:
            return SQUARE_COLOR_GREEN;
        case SquareBaseRed:
            return SQUARE_COLOR_RED;
        case SquareBaseYellow:
            return SQUARE_COLOR_YELLOW;
        default:
            return SQUARE_COLOR_BLUE;
    }
}

- (SquareBaseColor)getRandomColor {
    return arc4random() % 4;
}

- (void)beginAnimation {
    [UIView animateWithDuration:self.squareScalingDuration
                          delay: self.squareScalingDelay
                        options: UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear
     
                     animations: ^{
                         CATransform3D layerTransform = CATransform3DMakeScale(SQUARE_BASE_ENDING_SIZE / SQUARE_BASE_STARTING_SIZE, SQUARE_BASE_ENDING_SIZE / SQUARE_BASE_STARTING_SIZE, 1.0);
                         
                         self.layer.transform = layerTransform;
                     }
     
                     completion:nil
     ];
}

- (void)pauseAnimation {
    CFTimeInterval mediaTime = CACurrentMediaTime();
    CFTimeInterval pausedTime = [self.layer convertTime:mediaTime fromLayer: nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}

- (void)unPauseAnimation {
    self.layer.speed = 1.0;
}

- (void)endAnimation {
    [UIView animateWithDuration:0.2f
                          delay: 0
                        options: UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
     
                     animations: ^{
                         CATransform3D layerTransform = CATransform3DMakeScale(0, 0, 1.0);
                         
                         self.layer.transform = layerTransform;
                     }
     
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }
     ];
}

- (void)doAction {
    --self.squareTouches;
    if (self.squareTouches == 0) {
        [_squareGrid removeSquare:self];
        
        [self removeFromSuperview];
        [[NSNotificationCenter defaultCenter] postNotificationName:SQUARE_DESTROYED object:self];
    }
}

@end
