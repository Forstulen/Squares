//
//  SquareBase.m
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import "UIImage+UIImageAdditions.h"
#import "SquareExplosion.h"
#import "SquareBase.h"
#import "SquareGrid.h"
#import "defines.h"

NSString * const squareColorArray[] = {
    @"SquareBaseOrange",
    @"SquareBaseYellow",
    @"SquareBasePane",
    @"SquareBaseCyan",
    @"SquareBaseNone"
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
        case SquareBaseOrange:
            return SQUARE_COLOR_ORANGE;
        case SquareBaseYellow:
            return SQUARE_COLOR_YELLOW;
        case SquareBasePane:
            return SQUARE_COLOR_PANE;
        case SquareBaseCyan:
            return SQUARE_COLOR_CYAN;
        default:
            return SQUARE_COLOR_CYAN;
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
    CFTimeInterval pausedTime = self.layer.timeOffset;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
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
        [[NSNotificationCenter defaultCenter] postNotificationName:SQUARE_DESTROYED object:self];
        
        SquareExplosion *explosion = [[SquareExplosion alloc] initWithFrame:((CALayer*)self.layer.presentationLayer).frame];
        
        [self.superview addSubview:explosion];
        [explosion startExplosion:((CALayer*)self.layer.presentationLayer).frame withColor:[self getUIColor:self.squareColor]];
        
        [_squareGrid removeSquare:self];
        [self removeFromSuperview];
    }
}

@end
