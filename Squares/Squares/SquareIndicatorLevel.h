//
//  SquareIndicatorLevel.h
//  Squares
//
//  Created by Romain on 4/25/14.
//
//

#import <UIKit/UIKit.h>

@interface SquareIndicatorLevel : UIView {
    UILabel     *_squareLevelLabel;
}

+ (SquareIndicatorLevel *)squareIndicatorLevelWithParent:(UIView *)parent withMessage:(NSString *)message;

@end
