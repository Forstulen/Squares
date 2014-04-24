//
//  SquareGrid.m
//  Squares
//
//  Created by Romain on 4/5/14.
//
//

#import "SquareGrid.h"
#import "SquareBase.h"
#import "SquareIndestructible.h"
#import "SquareGameOver.h"
#import "SquareResilient.h"
#import "SquareExponential.h"
#import "defines.h"

NSString * const squareTypeArray[] = {
    @"SquareTypeBase",
    @"SquareTypeIndestructible",
    @"SquareTypeGameOver",
    @"SquareTypeResilient",
    @"SquareTypeExponential",
    @"SquareTypeNone"
};

@implementation SquareGrid

+ (SquareGrid *)squareGridWithFrame:(CGRect)frame {
    return [[SquareGrid alloc] initWithFrame:frame];
}

+ (NSString*)squareTypeEnumToString:(SquareType)enumVal
{
    return squareTypeArray[enumVal];
}

+ (SquareType)squareTypeStringToEnum:(NSString*)strVal
{
    int retVal;
    for(int i = 0; i < sizeof(squareTypeArray) - 1; i++)
    {
        if([(NSString*)squareTypeArray[i] isEqual:strVal])
        {
            retVal = i;
            break;
        }
    }
    return (SquareType)retVal;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super init]) {
        CGFloat realHeight = (frame.size.height - ((frame.size.height) * SQUARE_GRID_PADDING_PERCENT / 100));
        CGFloat realWidth = (frame.size.width - ((frame.size.width) * SQUARE_GRID_PADDING_PERCENT / 100));
        NSUInteger nbItemsRow = realHeight / SQUARE_GRID_BLOCK_SIZE;
        NSUInteger nbItemsCol = realWidth / SQUARE_GRID_BLOCK_SIZE;
        CGFloat paddingRow = (realHeight - nbItemsRow * SQUARE_GRID_BLOCK_SIZE) / (CGFloat)nbItemsRow + 1;
        CGFloat paddingCol = (realWidth - nbItemsCol * SQUARE_GRID_BLOCK_SIZE) / (CGFloat)nbItemsCol + 1;
        
        _squareGrid = [[NSMutableDictionary alloc] init];
        for (NSUInteger i = 0; i < nbItemsCol; ++i) {
            for (NSUInteger j = 0; j < nbItemsRow; ++j) {
                [_squareGrid setObject:[NSNull null] forKey:[NSValue valueWithCGPoint:CGPointMake((i * SQUARE_GRID_BLOCK_SIZE) + SQUARE_GRID_BLOCK_SIZE / 2 + paddingCol * (i + 1), (j * SQUARE_GRID_BLOCK_SIZE) + SQUARE_GRID_BLOCK_SIZE / 2 + paddingRow * (j + 1))]];
            }
        }
    }
    return self;
}

- (NSArray *)allKeys {
    return _squareGrid.allKeys;
}

- (NSArray *)allValues {
    return _squareGrid.allValues;
}

- (NSArray *)shuffleAllValues {
    NSMutableArray *copy = [NSMutableArray arrayWithArray:[self allValues]];
    
    for (NSUInteger i = 0; i < copy.count; ++i) {
        NSInteger nElements = copy.count - i;
        NSInteger n = arc4random_uniform(nElements) + i;
        [copy exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return copy;
}

- (NSArray *)shuffleAllKeys {
    NSMutableArray *copy = [NSMutableArray arrayWithArray:[self allKeys]];
    
    for (NSUInteger i = 0; i < copy.count; ++i) {
        NSInteger nElements = copy.count - i;
        NSInteger n = arc4random_uniform(nElements) + i;
        [copy exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return copy;
}

- (void)resetValues {
    for (NSValue *val in [self allKeys]) {
        [_squareGrid setObject:[NSNull null] forKey:val];
    }
    _squareNumber = 0;
}

- (void)activateSquareAction:(SquareBase *)square {
    [square doAction];
}

- (void)removeSquare:(SquareBase *)square {
    NSArray *keys = [_squareGrid allKeysForObject:square];
    
    [square removeFromSuperview];
    if (keys.count) {
        [_squareGrid setObject:[NSNull null] forKey:keys[0]];
        --_squareNumber;
    }
}

- (CGPoint)getRandomValueFromPoint:(CGPoint)point {
    return CGPointMake(point.x + point.x * (arc4random() % SQUARE_GRID_RANDOM_WINDOW) / 100.0f * (arc4random() % 2 ? 1 : -1),
                       point.y + point.y * (arc4random() % SQUARE_GRID_RANDOM_WINDOW) / 100.0f * (arc4random() % 2 ? 1 : -1));
}

- (SquareBase *)getSquare:(NSValue *)val {
    return [_squareGrid objectForKey:val];
}

- (BOOL)isEnoughSpaceWithFrame:(CGRect)frame {
    for (SquareBase *image in [self allValues]) {
        if ((id)image == [NSNull null]) {
            continue;
        }
        
        CGRect collider = ((CALayer*)image.layer.presentationLayer).frame;
        
        if (CGRectIntersectsRect(collider, frame)) {
            return false;
        }
    }
    return true;
}

- (SquareBase *)getSquareWithType:(SquareType)type withPoint:(CGPoint)point {
    switch (type) {
        case SquareTypeBase:
            return [SquareBase squareBaseWithPosition:point withGrid:self];
        case SquareTypeIndestructible:
            return [SquareIndestructible squareIndestructibleWithPosition:point withGrid:self];
        case SquareTypeGameOver:
            return [SquareGameOver squareGameOverWithPosition:point withGrid:self];
        case SquareTypeResilient:
            return [SquareResilient squareResilientWithPosition:point withGrid:self];
        case SquareTypeExponential:
            return [SquareExponential squareExponentialWithPosition:point withGrid:self];
        default:
            return [SquareBase squareBaseWithPosition:point withGrid:self];
    }
}

- (SquareBase *)getNewSquare:(SquareType)type {
    for (NSValue *val in [self shuffleAllKeys]) {
        if ([_squareGrid objectForKey:val] == [NSNull null]) {
            CGPoint point = [self getRandomValueFromPoint:[val CGPointValue]];
            
            if ([self isEnoughSpaceWithFrame:CGRectMake(point.x - SQUARE_GRID_BLOCK_SIZE * SQUARE_GRID_MIN_SPACE_PERCENT / 100.0f,
                                                        point.y - SQUARE_GRID_BLOCK_SIZE * SQUARE_GRID_MIN_SPACE_PERCENT / 100.0f,
                                                        SQUARE_GRID_BLOCK_SIZE + SQUARE_GRID_BLOCK_SIZE * SQUARE_GRID_MIN_SPACE_PERCENT / 100.0,
                                                        SQUARE_GRID_BLOCK_SIZE + SQUARE_GRID_BLOCK_SIZE * SQUARE_GRID_MIN_SPACE_PERCENT / 100.0f)]) {
                SquareBase *square = [self getSquareWithType:type withPoint:point];

                [_squareGrid setObject:square forKey:val];
                ++_squareNumber;
                return square;
            }
        }
    }
    return nil;
}

@end
