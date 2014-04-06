//
//  SquareGrid.h
//  Squares
//
//  Created by Romain on 4/5/14.
//
//

#import <Foundation/Foundation.h>

@class SquareImage;

@interface SquareGrid : NSObject {
    NSMutableDictionary     *_squareGrid;
}

+ (SquareGrid *)squareGridWithFrame:(CGRect)frame withSquareSize:(NSUInteger)size;

- (id)initWithFrame:(CGRect)frame withSize:(NSUInteger)size;
- (NSArray *)allKeys;
- (NSArray *)allValues;

- (void)removeSquare:(SquareImage *)square;
- (SquareImage *)getNewSquare;
- (SquareImage *)getSquare:(NSValue *)val;

@end
