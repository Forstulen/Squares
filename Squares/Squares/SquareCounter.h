//
//  SquareCounter.h
//  Squares
//
//  Created by Romain on 4/23/14.
//
//

#import <Foundation/Foundation.h>

@interface SquareCounter : UIView {
    CADisplayLink   *_squareCounterLoop;
    NSUInteger  _squareCounter;
    CGFloat     _squareElapsedTime;
    
    UILabel     *_squareCounterLabel;
}

- (id)initWithParent:(UIView *)view;
- (void)startCounter:(NSUInteger)counter;

@end
