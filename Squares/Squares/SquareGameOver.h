//
//  SquareGameOver.h
//  Squares
//
//  Created by Romain on 4/7/14.
//
//

#import "SquareBase.h"

@interface SquareGameOver : SquareBase

+ (SquareBase *)squareGameOverWithPosition:(CGPoint)point withGrid:(SquareGrid *)grid;

- (id)initWithPoint:(CGPoint)point withGrid:(SquareGrid *)grid;
- (void)beginAnimation;

@end
