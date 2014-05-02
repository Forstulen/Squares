//
//  SquareLevels.m
//  Squares
//
//  Created by Romain on 4/8/14.
//
//

#import "NSDictionaryAdditions.h"
#import "SquareBase.h"
#import "SquareLevels.h"
#import "defines.h"

@interface SquareLevelsManager ()

- (id)init;

@end

@implementation SquareLevelsManager

+ (id)sharedSquareLevelsManager {
    static SquareLevelsManager *shared = nil;
    @synchronized(self) {
        if (shared == nil)
            shared = [[self alloc] init];
    }
    return shared;
}

- (id)init {
    if (self = [super init]) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:SQUARE_LEVELS_PLIST ofType:@"plist"];
        NSDictionary *gameType = [[NSDictionary alloc] initWithContentsOfFile:plist];
        
        _squareLevelsPlay = [gameType safeObjectForKey:SQUARE_LEVELS_TRAINING];
        _squareLevelsHardcore = [gameType safeObjectForKey:SQUARE_LEVELS_HARDCORE];
        _squareGameType = SquareLevelsPlay;
        [self setGameType:_squareGameType];
        [self setProperties];
    }
    return self;
}

- (void)setProperties {
    _squareLevelDetail = (NSString *)[_squareCurrentLevel safeObjectForKey:SQUARE_LEVELS_LEVEL_DETAIL];
    _squareRefreshDelay = [(NSNumber *)[_squareCurrentLevel safeObjectForKey:SQUARE_LEVELS_REFRESH_DELAY] floatValue];
    _squareSpawnDelay = [(NSNumber *)[_squareCurrentLevel safeObjectForKey:SQUARE_LEVELS_SPAWN_DELAY] floatValue];
    _squareRespawn = [(NSNumber *)[_squareCurrentLevel safeObjectForKey:SQUARE_LEVELS_RESPAWN] boolValue];
    _squareNextLevel = [(NSNumber *)[_squareCurrentLevel safeObjectForKey:SQUARE_LEVELS_NEXT_LEVEL] floatValue];
    _squareSquareNumber = [(NSNumber *)[_squareCurrentLevel safeObjectForKey:SQUARE_LEVELS_SQUARE_NUMBER] floatValue];
    _squareInactivityDelay = [(NSNumber *)[_squareCurrentLevel safeObjectForKey:SQUARE_LEVELS_INACTIVITY_DELAY] floatValue];
    _squareAvailableItems = [_squareCurrentLevel safeObjectForKey:SQUARE_LEVELS_AVAILABLE_SQUARES];
}

- (void)setGameType:(SquareGameType)gameType {
    _squareGameType = gameType;
    
    [self resetLevel];
}

- (void)setNextLevel {
    if (_squareGameType == SquareLevelsPlay) {
        if (_squareCurrentIndex < _squareLevelsPlay.count - 1) {
            ++_squareCurrentIndex;
            _squareCurrentLevel = _squareLevelsPlay[_squareCurrentIndex];
            [self setProperties];
        }
    }
}


- (void)resetLevel {
    if (_squareGameType == SquareLevelsPlay) {
        _squareCurrentLevel = _squareLevelsPlay[0];
    } else {
        _squareCurrentLevel = _squareLevelsHardcore[0];
    }
    _squareCurrentIndex = 0;
    [self setProperties];
}


@end
