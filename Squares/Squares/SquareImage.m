//
//  SquareImage.m
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import "SquareImage.h"

@implementation SquareImage

+ (SquareImage*)squareImageWithDuration:(CGFloat)duration withPosition:(CGPoint)point {
    SquareImage *square = [[SquareImage alloc] initWithFrame:CGRectMake(point.x, point.y, 1, 1)];
    
    square.squareScalingDuration = duration;
    square.squareScalingDelay = 0.0;
    [square startScaling];
    
    return square;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"square-clip-art-15.png"];
    }
    return self;
}

- (void)startScaling {
    [UIView animateWithDuration:self.squareScalingDuration
                          delay: self.squareScalingDelay
                        options: UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear
     
                     animations: ^{
                         CATransform3D layerTransform = CATransform3DMakeScale(150, 150, 1.0);
                         
                         self.layer.transform = layerTransform;
                     }
     
                     completion:nil
     ];
}

@end
