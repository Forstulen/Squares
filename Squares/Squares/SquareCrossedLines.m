//
//  SquareCrossedLines.m
//  Squares
//
//  Created by Romain on 4/27/14.
//
//

#import "SquareCrossedLines.h"
#import "SquareBase.h"

@implementation SquareCrossedLines

+ (SquareCrossedLines *)squareCrossedLinesWithFrame:(CGRect)rect withParent:(UIView *)parent {
    return [[SquareCrossedLines alloc] initWithFrame:rect withParent:parent];
}

- (id)initWithFrame:(CGRect)frame withParent:(UIView *)parent
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createLinesWithFrame:frame withParent:parent];
    }
    return self;
}

- (void)createLinesWithFrame:(CGRect)rect withParent:(UIView *)parent {
    CGFloat value1 = CGRectGetMinY(rect) + arc4random() % (int)CGRectGetMaxY(rect);
    CGPoint startPoint1 	= CGPointMake(CGRectGetMinX(rect), value1);
    CGPoint endPoint1 	= CGPointMake(CGRectGetMaxX(rect), value1);
    
    CGFloat value2 = CGRectGetMinX(rect) + arc4random() % (int)CGRectGetMaxX(rect);
    CGPoint startPoint2 = CGPointMake(value2, CGRectGetMinY(rect));
    CGPoint endPoint2 = CGPointMake(value2, CGRectGetMaxY(rect));
    
    if (arc4random() % 2 == 1)
        [self createLineWithFrame:rect withParent:parent withStartPoint:startPoint1 withEndPoint:endPoint1];
    else
        [self createLineWithFrame:rect withParent:parent withStartPoint:endPoint1 withEndPoint:startPoint1];
    
    if (arc4random() % 2 == 1)
        [self createLineWithFrame:rect withParent:parent withStartPoint:startPoint2 withEndPoint:endPoint2];
    else
        [self createLineWithFrame:rect withParent:parent withStartPoint:endPoint2 withEndPoint:startPoint2];
    
    [parent insertSubview:self atIndex:0];
}

- (void)createLineWithFrame:(CGRect)rect withParent:(UIView *)parent withStartPoint:(CGPoint)start withEndPoint:(CGPoint)end {
    
    UIColor *color = [SquareBase randomColor];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:start];
    [path addLineToPoint:end];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = rect;
    pathLayer.bounds = rect;
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = color.CGColor;
    pathLayer.backgroundColor = [UIColor clearColor].CGColor;
    pathLayer.shadowColor = color.CGColor;
    pathLayer.shadowOffset = CGSizeMake(0, 0);
    pathLayer.shadowOpacity = 1;
    pathLayer.shadowRadius = 3.0f;
    pathLayer.masksToBounds = NO;
    pathLayer.lineWidth = 0.1f;
    pathLayer.fillColor = nil;
    pathLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:pathLayer];
    [self addAnimations:pathLayer];
}

- (void)addAnimations:(CAShapeLayer *)shapeLayer {
    CAMediaTimingFunction *customMediaTimingFunction = [CAMediaTimingFunction functionWithControlPoints:0.00 :1.00 :0.19 :1.00];
    
    CABasicAnimation *pathAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation1.duration = 4.0;
    pathAnimation1.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation1.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation1.removedOnCompletion = NO;
    pathAnimation1.fillMode = kCAFillModeForwards;
    pathAnimation1.timingFunction = customMediaTimingFunction;
    
    CABasicAnimation *pathAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    pathAnimation2.beginTime = CACurrentMediaTime() + 0.5;
    pathAnimation2.duration = 4.0;
    pathAnimation2.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation2.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation2.removedOnCompletion = NO;
    pathAnimation2.fillMode = kCAFillModeForwards;
    pathAnimation2.timingFunction = customMediaTimingFunction;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.beginTime = CACurrentMediaTime() + 0.4;
    alphaAnimation.duration = 4.0;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    alphaAnimation.removedOnCompletion = NO;
    alphaAnimation.fillMode = kCAFillModeForwards;
    alphaAnimation.timingFunction = customMediaTimingFunction;
    alphaAnimation.delegate = self;
    
    [shapeLayer addAnimation:pathAnimation1 forKey:@"strokeEnd"];
    [shapeLayer addAnimation:pathAnimation2 forKey:@"strokeStart"];
    [shapeLayer addAnimation:alphaAnimation forKey:@"opacity"];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

@end
