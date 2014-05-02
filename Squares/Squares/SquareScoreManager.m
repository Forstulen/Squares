//
//  SquareScoreManager.m
//  Squares
//
//  Created by Romain on 4/8/14.
//
//

#import "SquareScoreManager.h"
#import "defines.h"

@interface SquareScoreManager ()

- (id)init;

@end

@implementation SquareScoreManager

+ (SquareScoreManager *)sharedSquareScoreManager {
    static SquareScoreManager *shared = nil;
    @synchronized(self) {
        if (shared == nil)
            shared = [[self alloc] init];
    }
    return shared;
}

- (id)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(increaseScore:) name:SQUARE_DESTROYED object:nil];
        [self resetScore];
        [self loadBestScore];
    }
    return self;
}

- (void)dealloc {
    [self saveBestScore];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)resetScore {
    _squareScore = 0;
    _squareChain = 0;
    _squareBonusMultiplier = 0;
}

- (void)resetMultiplier {
    _squareBonusMultiplier = 0;
    _squareChain = 0;
}

- (void)increaseScore:(NSNotification *)notification {
    SquareBase  *square = notification.object;
    
    ++_squareChain;
    if (_squareBonusMultiplier < SQUARE_MULTIPLIER_MAX && (sqrt(_squareChain) - floor(sqrt(_squareChain))) == 0) {
        ++_squareBonusMultiplier;
        
        if (_squareBonusMultiplier > 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:SQUARE_MULTIPLIER object:[NSNumber numberWithInteger:_squareBonusMultiplier]];
        }
    }
    
    if (_squareScore > SQUARE_SCORE_MAX) {
        _squareScore = SQUARE_SCORE_MAX;
        [[NSNotificationCenter defaultCenter] postNotificationName:SQUARE_BEST_SCORE_EVER object:nil userInfo:nil];
    } else if (square.squareScore < 0) {
        _squareScore *= (100 + square.squareScore) / 100.0f;
        [[NSNotificationCenter defaultCenter] postNotificationName:SQUARE_MULTIPLIER_RESET object:nil];
    } else if (_squareBonusMultiplier) {
        _squareScore += square.squareScore * _squareBonusMultiplier;
    } else {
        _squareScore += square.squareScore;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SQUARE_UPDATE_SCORE object:nil userInfo:nil];
    
    if (_squareScore > _squareBestScoreHardCore && _squareGameType == SquareLevelsHardcore) {
        _squareBestScoreHardCore = _squareScore;
    }
    if (_squareScore > _squareBestScoreTraining && _squareGameType == SquareLevelsPlay) {
        _squareBestScoreTraining = _squareScore;
    }
}

- (NSUInteger)getCorrespondingBestScore {
    [self saveBestScore];
    if (_squareGameType == SquareLevelsHardcore) {
        return self.squareBestScoreHardCore;
    } else {
        return self.squareBestScoreTraining;
    }
}

- (void)setGameType:(SquareGameType)type {
    _squareGameType = type;
}

- (void)loadBestScore {
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    
    _squareBestScoreTraining = 0;
    if ([defaults integerForKey:SQUARE_BEST_SCORE_TRAINING]) {
        _squareBestScoreTraining = [defaults integerForKey:SQUARE_BEST_SCORE_TRAINING];
    }
    
    _squareBestScoreHardCore = 0;
    if ([defaults integerForKey:SQUARE_BEST_SCORE_HARDCORE]) {
        _squareBestScoreHardCore = [defaults integerForKey:SQUARE_BEST_SCORE_HARDCORE];
    }
}

- (void)saveBestScore {
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setInteger:self.squareBestScoreTraining forKey:SQUARE_BEST_SCORE_TRAINING];
    [defaults setInteger:self.squareBestScoreHardCore forKey:SQUARE_BEST_SCORE_HARDCORE];
    [defaults synchronize];
}

@end
