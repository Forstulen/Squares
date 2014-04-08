//
//  SquareBase.h
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    SquareBaseBlue = 0,
    SquareBaseRed,
    SquareBaseYellow,
    SquareBaseGreen,
    SquareBaseNone
}SquareBaseColor;

@class SquareGrid;

@interface SquareBase : UIImageView {
    SquareGrid          *_squareGrid;
}

- (UIColor *)getUIColor:(SquareBaseColor)color;
- (SquareBaseColor)getRandomColor;
- (void)beginAnimation;
- (void)pauseAnimation;
- (void)unPauseAnimation;
- (void)endAnimation;
- (void)doAction;

- (id)initWithPoint:(CGPoint)point withGrid:(SquareGrid *)grid;

+ (SquareBase *)squareBaseWithPosition:(CGPoint)point withGrid:(SquareGrid *)grid;
+ (NSString*)squareColorEnumToString:(SquareBaseColor)enumVal;
+ (SquareBaseColor)squareColorStringToEnum:(NSString*)strVal;

@property (nonatomic) SquareBaseColor squareColor;
@property (nonatomic) CGFloat squareScalingDuration;
@property (nonatomic) CGFloat squareScalingDelay;
@property (nonatomic) NSUInteger    squareScore;
@property (nonatomic) NSUInteger    squareTouches;

@end
