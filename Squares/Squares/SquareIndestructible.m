//
//  SquareIndestrucible.m
//  Squares
//
//  Created by Romain on 4/7/14.
//
//

#import "UIImage+UIImageAdditions.h"
#import "SquareIndestructible.h"
#import "SquareGrid.h"
#import "defines.h"

@implementation SquareIndestructible

+ (SquareBase*)squareIndestructibleWithPosition:(CGPoint)point withGrid:(SquareGrid *)grid {
    return[[SquareIndestructible alloc] initWithPoint:point withGrid:grid];
}

- (id)initWithPoint:(CGPoint)point withGrid:(SquareGrid *)grid {
    if (self = [super initWithFrame:CGRectMake(point.x, point.y, SQUARE_INDESTRUCTIBLE_STARTING_SIZE, SQUARE_INDESTRUCTIBLE_STARTING_SIZE)]) {
        _squareGrid = grid;
        
        self.squareColor = [self getRandomColor];
        self.squareScalingDuration = SQUARE_INDESTRUCTIBLE_DURATION;
        self.squareScalingDelay = SQUARE_INDESTRUCTIBLE_DELAY;
        self.squareScore = SQUARE_INDESTRUCTIBLE_SCORE;
        self.squareTouches = SQUARE_INDESTRUCTIBLE_TOUCHES_NUMBER;
        self.image = [UIImage imageNamed:SQUARE_IMAGE_INDESTRUCTIBLE withColor:[self getUIColor:self.squareColor]];
    }
    return self;
}

- (void)beginAnimation {
    [UIView animateWithDuration:self.squareScalingDuration
                          delay: self.squareScalingDelay
                        options: UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear
     
                     animations: ^{
                         CATransform3D layerTransform = CATransform3DMakeScale(SQUARE_INDESTRUCTIBLE_ENDING_SIZE / SQUARE_INDESTRUCTIBLE_STARTING_SIZE, SQUARE_INDESTRUCTIBLE_ENDING_SIZE / SQUARE_INDESTRUCTIBLE_STARTING_SIZE, 1.0);
                         
                         self.layer.transform = layerTransform;
                     }
     
                     completion:^(BOOL finished) {
                         [_squareGrid removeSquare:self];
                     }];
}

- (void)doAction {

}

@end
