//
//  SquareMultiplier.h
//  Squares
//
//  Created by Romain on 4/24/14.
//
//

#import <UIKit/UIKit.h>

@interface SquareMultiplier : UIView {
    UILabel     *_squareMultplierLabel;
}

+ (SquareMultiplier *)squareMultiplierWithParent:(UIView *)parent withMessage:(NSString *)message withPosition:(CGPoint)position;


@end
