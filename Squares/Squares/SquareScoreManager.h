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

+ (id)sharedSquareScoreManager;

- (void)resetScore;
- (void)resetMultiplier;
- (void)setGameType:(SquareGameType)type;
- (NSUInteger)getCorrespondingBestScore;

@property (nonatomic, readonly) NSUInteger squareScore;
@property (nonatomic) NSUInteger squareBonusMultiplier;
@property (nonatomic) NSUInteger squareBestScoreTraining;
@property (nonatomic) NSUInteger squareBestScoreHardCore;

@end
