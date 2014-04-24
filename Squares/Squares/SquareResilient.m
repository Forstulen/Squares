//
//  SquareResilient.m
//  Squares
//
//  Created by Romain on 4/7/14.
//
//

#import "UIImage+UIImageAdditions.h"
#import "SquareGrid.h"
#import "SquareResilient.h"
#import "defines.h"

@implementation SquareResilient

+ (SquareBase*)squareResilientWithPosition:(CGPoint)point withGrid:(SquareGrid *)grid {
    return[[SquareResilient alloc] initWithPoint:point withGrid:grid];
}

- (id)initWithPoint:(CGPoint)point withGrid:(SquareGrid *)grid {
    if (self = [super initWithFrame:CGRectMake(point.x, point.y, SQUARE_RESILIENT_STARTING_SIZE, SQUARE_RESILIENT_STARTING_SIZE)]) {
        _squareGrid = grid;
        
        self.squareColor = [self getRandomColor];
        self.squareScalingDuration = SQUARE_RESILIENT_DURATION;
        self.squareScalingDelay = SQUARE_RESILIENT_DELAY;
        self.squareScore = SQUARE_RESILIENT_SCORE;
        self.squareTouches = SQUARE_RESILIENT_TOUCHES_NUMBER;
        _squareResilientStep = 1;
        self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.png", SQUARE_IMAGE_RESILIENT, _squareResilientStep] withColor:[self getUIColor:self.squareColor]];
    }
    return self;
}

- (void)beginAnimation {
    [UIView animateWithDuration:self.squareScalingDuration
                          delay: self.squareScalingDelay
                        options: UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear
     
                     animations: ^{
                         CATransform3D layerTransform = CATransform3DMakeScale(SQUARE_RESILIENT_ENDING_SIZE / SQUARE_RESILIENT_STARTING_SIZE, SQUARE_RESILIENT_ENDING_SIZE / SQUARE_RESILIENT_STARTING_SIZE, 1.0);
                         
                         self.layer.transform = layerTransform;
                     }
     
                     completion:nil];
}

- (void)doAction {
    [super doAction];
    if (self.squareTouches > 0) {
        ++_squareResilientStep;
        self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.png", SQUARE_IMAGE_RESILIENT, _squareResilientStep] withColor:[self getUIColor:self.squareColor]];
    }
}


@end
