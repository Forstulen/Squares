//
//  SquareLevels.h
//  Squares
//
//  Created by Romain on 4/8/14.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    SquareLevelsPlay,
    SquareLevelsHardcore,
    SquareLevelsNone
}SquareGameType;

@interface SquareLevelsManager : NSObject {
    NSArray         *_squareLevelsPlay;
    NSArray         *_squareLevelsHardcore;
    
    NSDictionary    *_squareCurrentLevel;
    NSUInteger      _squareCurrentIndex;
}

+ (id)sharedSquareLevelsManager;
- (void)setGameType:(SquareGameType)gameType;
- (void)setNextLevel;
- (void)resetLevel;

@property (nonatomic, readonly) SquareGameType      squareGameType;
@property (nonatomic, readonly) CGFloat             squareRefreshDelay;
@property (nonatomic, readonly) CGFloat             squareSpawnDelay;
@property (nonatomic, readonly) BOOL                squareRespawn;
@property (nonatomic, readonly) CGFloat             squareNextLevel;
@property (nonatomic, readonly) CGFloat             squareSquareNumber;
@property (nonatomic, readonly) CGFloat             squareInactivityDelay;
@property (weak, readonly)  NSDictionary            *squareAvailableItems;

@end
