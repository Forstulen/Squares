//
//  SquareScoreManager.h
//  Squares
//
//  Created by Romain on 4/8/14.
//
//

#import <Foundation/Foundation.h>
#import "SquareLevels.h"
#import "SquareBase.h"

@interface SquareScoreManager : NSObject {
    NSUInteger      _squareChain;

    SquareGameType  _squareGameType;
}

+ (SquareScoreManager *)sharedSquareScoreManager;

- (void)resetScore;
- (void)resetMultiplier;
- (void)setGameType:(SquareGameType)type;
- (void)saveBestScore;
- (NSUInteger)getCorrespondingBestScore;

@property (nonatomic, readonly) NSUInteger squareScore;
@property (nonatomic, readonly) NSUInteger squareBonusMultiplier;
@property (nonatomic, readonly) NSUInteger squareBestScoreTraining;
@property (nonatomic, readonly) NSUInteger squareBestScoreHardCore;

@end
