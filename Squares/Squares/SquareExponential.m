//
//  SquarE_EXPONENTIAL.m
//  Squares
//
//  Created by Romain on 4/7/14.
//
//

#import "UIImage+UIImageAdditions.h"
#import "SquareGrid.h"
#import "defines.h"
#import "SquareExponential.h"

@implementation SquareExponential

+ (SquareBase *)squareExponentialWithPosition:(CGPoint)point withGrid:(SquareGrid *)grid {
    return[[SquareExponential alloc] initWithPoint:point withGrid:grid];
}

- (id)initWithPoint:(CGPoint)point withGrid:(SquareGrid *)grid {
    if (self = [super initWithFrame:CGRectMake(point.x, point.y, SQUARE_EXPONENTIAL_STARTING_SIZE, SQUARE_EXPONENTIAL_STARTING_SIZE)]) {
        _squareGrid = grid;
        
        self.squareColor = [self getRandomColor];
        self.squareScalingDuration = SQUARE_EXPONENTIAL_FIRST_STEP_DURATION + SQUARE_EXPONENTIAL_SECOND_STEP_DURATION;
        self.squareScalingDelay = SQUARE_EXPONENTIAL_DELAY;
        self.squareScore = SQUARE_EXPONENTIAL_SCORE;
        self.squareTouches = SQUARE_EXPONENTIAL_TOUCHES_NUMBER;
        self.image = [UIImage imageNamed:SQUARE_IMAGE_EXPONENTIAL withColor:[self getUIColor:self.squareColor]];
    }
    return self;
}

- (void)beginAnimation {
    CAAnimationGroup* group = [CAAnimationGroup animation];
    
    CABasicAnimation* smallScaling =  [CABasicAnimation animationWithKeyPath: @"transform"];
    CABasicAnimation* bigScaling =  [CABasicAnimation animationWithKeyPath: @"transform"];
    
    CATransform3D firstTransform = CATransform3DMakeScale(SQUARE_EXPONENTIAL_MIDDLE_SIZE / SQUARE_EXPONENTIAL_STARTING_SIZE, SQUARE_EXPONENTIAL_MIDDLE_SIZE / SQUARE_EXPONENTIAL_STARTING_SIZE, 1.0);
    CATransform3D secondTransform = CATransform3DMakeScale(SQUARE_EXPONENTIAL_ENDING_SIZE / SQUARE_EXPONENTIAL_STARTING_SIZE, SQUARE_EXPONENTIAL_ENDING_SIZE / SQUARE_EXPONENTIAL_STARTING_SIZE, 1.0);
    
    smallScaling.duration = SQUARE_EXPONENTIAL_FIRST_STEP_DURATION;
    [smallScaling setToValue:[NSValue valueWithCATransform3D:firstTransform]];
    smallScaling.beginTime = 0;
    smallScaling.removedOnCompletion = NO;
    smallScaling.fillMode = kCAFillModeForwards;
    smallScaling.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    bigScaling.duration = SQUARE_EXPONENTIAL_SECOND_STEP_DURATION;
    [bigScaling setToValue: [NSValue valueWithCATransform3D:secondTransform]];
    bigScaling.beginTime = SQUARE_EXPONENTIAL_FIRST_STEP_DURATION;
    bigScaling.removedOnCompletion = NO;
    bigScaling.fillMode = kCAFillModeForwards;
    bigScaling.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

 
    [group setDuration: self.squareScalingDuration];
    [group setAnimations: [NSArray arrayWithObjects:smallScaling, bigScaling, nil]];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    [self.layer addAnimation:group forKey:nil];
}

- (void)endAnimation {
    [self.layer removeAllAnimations];
    [super endAnimation];
}

@end