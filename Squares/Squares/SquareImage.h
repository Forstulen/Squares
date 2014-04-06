//
//  SquareImage.h
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    SquareImageBlue = 0,
    SquareImageRed,
    SquareImageYellow,
    SquareImageGreen
}SquareImageColor;

@interface SquareImage : UIImageView {
    SquareImageColor     _squareImageColor;
}

- (void)startScaling;
+ (SquareImage *)squareImageWithDuration:(CGFloat)duration withPosition:(CGPoint)point;

@property (nonatomic) CGFloat squareScalingDuration;
@property (nonatomic) CGFloat squareScalingDelay;

@end
