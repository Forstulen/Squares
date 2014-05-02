//
//  SquareMultiplier.m
//  Squares
//
//  Created by Romain on 4/24/14.
//
//

#import "SquareMultiplier.h"
#import "defines.h"

@implementation SquareMultiplier

+ (SquareMultiplier *)squareMultiplierWithParent:(UIView *)parent withMessage:(NSString *)message withPosition:(CGPoint)position {
    return [[SquareMultiplier alloc] initWithParent:parent withMessage:message withPosition:position];
}

- (id)initWithParent:(UIView *)parent withMessage:(NSString *)message withPosition:(CGPoint)pos {
    CGRect frame = CGRectMake(pos.x - 50, pos.y - 50, 100, 100);
    
    if (self = [super initWithFrame:frame]) {
        _squareMultplierLabel =[[UILabel alloc] init];
        _squareMultplierLabel.text = message;
        _squareMultplierLabel.font = SQUARE_FONT_BIG;
        _squareMultplierLabel.backgroundColor = [UIColor clearColor];
        _squareMultplierLabel.textColor = SQUARE_COLOR_YELLOW;
        _squareMultplierLabel.contentMode = UIViewContentModeScaleAspectFit;
        _squareMultplierLabel.textAlignment = NSTextAlignmentCenter;
        
        [parent insertSubview:self atIndex:0];
        [self addSubview:_squareMultplierLabel];
        self.backgroundColor = [UIColor clearColor];
        [self animateView];
    }
    return self;
}

- (void)animateView {
    self.alpha = 0.0f;
    [UIView animateWithDuration:1
                          delay:0
                        options: UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn
     
                     animations: ^{
                         self.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) {
                         [_squareMultplierLabel removeFromSuperview];
                         [self removeFromSuperview];
    }];
}

- (void)layoutSubviews {
    CGRect  frame;
    
    frame = _squareMultplierLabel.frame;
    frame.size.width = self.frame.size.width;
    frame.size.height = self.frame.size.height;
    frame.origin.x = 0;
    frame.origin.y = 0;
    _squareMultplierLabel.frame = frame;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    
    if (hitView == self) {
        return self.superview;
    }
    return hitView;
}

@end
