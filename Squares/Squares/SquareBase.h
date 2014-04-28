//
//  SquareBase.h
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    SquareBaseOrange = 0,
    SquareBaseYellow,
    SquareBasePane,
    SquareBaseCyan,
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
+ (UIColor*)randomColor;

@property (nonatomic) SquareBaseColor squareColor;
@property (nonatomic) CGFloat squareScalingDuration;
@property (nonatomic) CGFloat squareScalingDelay;
@property (nonatomic) NSUInteger    squareScore;
@property (nonatomic) NSUInteger    squareTouches;

@end
