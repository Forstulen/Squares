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

- (void)setEffectsLevel:(CGFloat)level;
- (void)setMusicLevel:(CGFloat)level;

@property (nonatomic, readonly) CGFloat effectsLevel;
@property (nonatomic, readonly) CGFloat musicLevel;
@property (nonatomic, readonly) BOOL isPlaying;

@end
