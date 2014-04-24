//
//  SquareExplosion.h
//  Squares
//
//  Created by Romain on 4/24/14.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SquareExplosion : UIView {
    CAEmitterLayer  *_squareExplosionEmitter;
}

- (void)startExplosion:(CGRect)frame withColor:(UIColor *)color;

@end
