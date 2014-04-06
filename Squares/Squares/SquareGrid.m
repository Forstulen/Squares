//
//  SquareGrid.m
//  Squares
//
//  Created by Romain on 4/5/14.
//
//

#import "SquareGrid.h"
#import "SquareImage.h"

@implementation SquareGrid

+ (SquareGrid *)squareGridWithFrame:(CGRect)frame withSquareSize:(NSUInteger)size {
    return [[SquareGrid alloc] initWithFrame:frame withSize:size];
}

- (id)initWithFrame:(CGRect)frame withSize:(NSUInteger)size {
    if (self = [super init]) {
        NSUInteger nbItemsRow = frame.size.height / size;
        NSUInteger nbItemsCol = frame.size.width / size;
        CGFloat paddingRow = (frame.size.height - nbItemsRow * size) / (CGFloat)nbItemsRow + 1;
        CGFloat paddingCol = (frame.size.width - nbItemsCol * size) / (CGFloat)nbItemsCol + 1;
        
        _squareGrid = [[NSMutableDictionary alloc] init];
        for (NSUInteger i = 0; i < nbItemsCol; ++i) {
            for (NSUInteger j = 0; j < nbItemsRow; ++j) {
                [_squareGrid setObject:[NSNull null] forKey:[NSValue valueWithCGPoint:CGPointMake((i * size) + size / 2 + paddingCol * (i + 1), (j * size) + size / 2 + paddingRow * (j + 1))]];
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

- (void)removeSquare:(SquareImage *)square {
    NSArray *keys = [_squareGrid allKeysForObject:square];
    
    [_squareGrid setObject:[NSNull null] forKey:keys[0]];
}

- (CGPoint)getRandomValueFromPoint:(CGPoint)point withRandomWindow:(NSInteger)randomWindow {
    return point;
    return CGPointMake(point.x + point.x * (arc4random() % randomWindow) / 100.0f * (arc4random() % 2 ? 1 : -1),
                       point.y + point.y * (arc4random() % randomWindow) / 100.0f * (arc4random() % 2 ? 1 : -1));
}

- (SquareImage *)getSquare:(NSValue *)val {
    return [_squareGrid objectForKey:val];
}

- (BOOL)isEnoughSpaceWithFrame:(CGRect)frame {
    for (SquareImage *image in [self allValues]) {
        if (image == [NSNull null]) {
            continue;
        }
        
        CGRect collider = ((CALayer*)image.layer.presentationLayer).frame;
        
        if (CGRectIntersectsRect(collider, frame)) {
            return false;
        }
    }
    return true;
}

- (SquareImage *)getNewSquare {
    for (NSValue *val in [self shuffleAllKeys]) {
        if ([_squareGrid objectForKey:val] == [NSNull null]) {
            CGPoint point = [self getRandomValueFromPoint:[val CGPointValue] withRandomWindow:15];
            
            if ([self isEnoughSpaceWithFrame:CGRectMake(point.x - 50, point.y - 50, 100, 100)]) {
                SquareImage *square = [SquareImage squareImageWithDuration:5 withPosition:point];
            
                [_squareGrid setObject:square forKey:val];
                return square;
            }
        }
    }
    return nil;
}

@end
