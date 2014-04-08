//
//  SquareGrid.h
//  Squares
//
//  Created by Romain on 4/5/14.
//
//

#import <Foundation/Foundation.h>

@class SquareBase;

typedef enum {
    SquareTypeBase = 0,
    SquareTypeIndestructible,
    SquareTypeGameOver,
    SquareTypeResilient,
    SquareTypeExponential,
    SquareTypeNone
}SquareType;

@protocol SquareGridDelegate <NSObject>
- (void)generateSquare;
@end

@interface SquareGrid : NSObject {
    NSMutableDictionary     *_squareGrid;
}

+ (SquareGrid *)squareGridWithFrame:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame;
- (NSArray *)allKeys;
- (NSArray *)allValues;
- (NSArray *)shuffleAllKeys;
- (NSArray *)shuffleAllValues;
- (void)resetValues;

- (void)activateSquareAction:(SquareBase *)square;
- (void)removeSquare:(SquareBase *)square;
- (SquareBase *)getNewSquare:(SquareType)type;
- (SquareBase *)getSquare:(NSValue *)val;

@property (strong, nonatomic) id<SquareGridDelegate> squareGridDelegate;

@end
