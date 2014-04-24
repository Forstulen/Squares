//
//  SquareSoundManager.h
//  Squares
//
//  Created by Romain on 4/24/14.
//
//

#import <Foundation/Foundation.h>

@interface SquareSoundManager : NSObject


+ (SquareSoundManager *)sharedSquareSoundManager;

- (void)playSound:(NSString *)name;

- (void)playBgMusic:(NSString *)music;


- (void)pauseSounds;
- (void)unpauseSounds;

- (void)stop;
- (void)stopBgMusic;

@end
