//
//  SquareResilient.h
//  Squares
//
//  Created by Romain on 4/7/14.
//
//

#import "SquareBase.h"

@interface SquareResilient : SquareBase {
    NSUInteger      _squareResilientStep;
}

+ (SquareBase *)squareResilientWithPosition:(CGPoint)point withGrid:(SquareGrid *)grid;

- (id)initWithPoint:(CGPoint)point withGrid:(SquareGrid *)grid;
- (void)beginAnimation;
- (void)doAction;

@end
