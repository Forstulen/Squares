//
//  SquareDemo.m
//  Squares
//
//  Created by Romain on 4/24/14.
//
//

#import "SquareDemo.h"
#import "defines.h"
#import "SquareExplosion.h"

@implementation SquareDemo

+ (SquareDemo *)squareDemoWithPosition:(CGPoint)point {
    return [[SquareDemo alloc] initWithPoint:point withGrid:nil];
}

- (id)initWithPoint:(CGPoint)point withGrid:(SquareGrid *)grid {
    if (self = [super initWithPoint:point withGrid:grid]) {
        self.squareScalingDuration = 0.8f;
        [self beginAnimation];
    }
    return self;
}

- (void)beginAnimation {
    [UIView animateWithDuration:self.squareScalingDuration
                          delay: self.squareScalingDelay
                        options: UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear
     
                     animations: ^{
                         CATransform3D layerTransform = CATransform3DMakeScale(SQUARE_BASE_ENDING_SIZE / SQUARE_BASE_STARTING_SIZE, SQUARE_BASE_ENDING_SIZE / SQUARE_BASE_STARTING_SIZE, 1.0);
                         
                         self.layer.transform = layerTransform;
                     }
     
                     completion:^(BOOL finished) {
                         [self doAction];
                     }
     ];
}

- (void)doAction {
    SquareExplosion *explosion = [[SquareExplosion alloc] initWithFrame:((CALayer*)self.layer.presentationLayer).frame];
        
    [self.superview addSubview:explosion];
    [explosion startExplosion:((CALayer*)self.layer.presentationLayer).frame withColor:[self getUIColor:self.squareColor]];
        
    [self removeFromSuperview];
}


@end
