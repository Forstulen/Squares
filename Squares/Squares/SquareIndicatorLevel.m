//
//  SquareIndicatorLevel.m
//  Squares
//
//  Created by Romain on 4/25/14.
//
//

#import "SquareIndicatorLevel.h"
#import "defines.h"

@implementation SquareIndicatorLevel

+ (SquareIndicatorLevel *)squareIndicatorLevelWithParent:(UIView *)parent withMessage:(NSString *)message {
    return [[SquareIndicatorLevel alloc] initWithParent:parent withMessage:message ];
}

- (id)initWithParent:(UIView *)parent withMessage:(NSString *)message {
    CGRect frame = CGRectMake(0, 0, parent.frame.size.width, parent.frame.size.height);
    
    if (self = [super initWithFrame:frame]) {
        _squareLevelLabel = [[UILabel alloc] init];
        _squareLevelLabel.text = message;
        _squareLevelLabel.font = SQUARE_FONT_HUGE;
        _squareLevelLabel.textColor = [UIColor whiteColor];
        _squareLevelLabel.backgroundColor = [UIColor clearColor];
        _squareLevelLabel.contentMode = UIViewContentModeScaleAspectFit;
        _squareLevelLabel.textAlignment = NSTextAlignmentCenter;
        _squareLevelLabel.numberOfLines = 0;
       
        [parent insertSubview:self atIndex:0];
        [self addSubview:_squareLevelLabel];
        self.backgroundColor = [UIColor clearColor];
        [self animateView];
    }
    return self;
}

- (void)animateView {
    self.center = CGPointMake(-(self.superview.frame.size.width / 2), self.superview.frame.size.height / 2);
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn
     
                     animations: ^{
                         self.center = CGPointMake((self.superview.frame.size.width / 2), self.superview.frame.size.height / 2);
                     }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(dismissIndicator) withObject:nil afterDelay:1];
                     }];
}

- (void)dismissIndicator {
    [_squareLevelLabel removeFromSuperview];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (void)layoutSubviews {
    CGRect  frame;
    
    frame = _squareLevelLabel.frame;
    frame.size.width = self.frame.size.width;
    frame.size.height = self.frame.size.height;
    frame.origin.x = 0;
    frame.origin.y = 0;
    _squareLevelLabel.frame = frame;
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
