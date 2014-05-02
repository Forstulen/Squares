//
//  SquareCounter.m
//  Squares
//
//  Created by Romain on 4/23/14.
//
//

#import "SquareCounter.h"
#import "defines.h"

@implementation SquareCounter

- (id)initWithParent:(UIView *)parent {
    CGRect frame = CGRectMake(0, 0, parent.frame.size.width, parent.frame.size.height);
    
    if (self = [super initWithFrame:frame]) {
        _squareCounterLabel =[[UILabel alloc] init];
        _squareCounterLabel.text = @"3";
        _squareCounterLabel.font = SQUARE_FONT_HUGE;
        _squareCounterLabel.textColor = [UIColor whiteColor];
        _squareCounterLabel.backgroundColor = [UIColor clearColor];
        _squareCounterLabel.contentMode = UIViewContentModeScaleAspectFit;
        _squareCounterLabel.textAlignment = NSTextAlignmentCenter;
        
        [parent addSubview:self];
        self.userInteractionEnabled = YES;
        [self addSubview:_squareCounterLabel];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)startCounter:(NSUInteger)counter {
    _squareCounterLoop = [CADisplayLink displayLinkWithTarget:self
                                                  selector:@selector(update:)];
    [_squareCounterLoop setFrameInterval:SQUARE_FRAME_INTERVAL];
    [_squareCounterLoop addToRunLoop:[NSRunLoop mainRunLoop]
                          forMode:NSRunLoopCommonModes];
    
    _squareCounter = counter;
    _squareCounterLabel.text = [NSString stringWithFormat:@"%d", _squareCounter];
    _squareElapsedTime = CACurrentMediaTime();
}

- (void)update:(CADisplayLink*)displayLink {
    CGFloat elapsedTime = CACurrentMediaTime() - _squareElapsedTime;
    
    if (elapsedTime >= 1.0) {
        --_squareCounter;
        _squareCounterLabel.text = [NSString stringWithFormat:@"%d", _squareCounter];
        _squareElapsedTime = CACurrentMediaTime();
    }
    
    if (_squareCounter == 0) {
        [_squareCounterLoop invalidate];
        [_squareCounterLoop removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        _squareCounterLoop = nil;
        [_squareCounterLabel removeFromSuperview];
        [self removeFromSuperview];
    }
}

- (void)layoutSubviews {
    CGRect  frame;
    
    frame = _squareCounterLabel.frame;
    frame.size.width = self.frame.size.width;
    frame.size.height = self.frame.size.height;
    frame.origin.x = 0;
    frame.origin.y = 0;
    _squareCounterLabel.frame = frame;
}

@end
