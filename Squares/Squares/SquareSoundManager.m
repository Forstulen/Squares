//
//  SquareSoundManager.m
//  Squares
//
//  Created by Romain on 4/24/14.
//
//

#import "SquareSoundManager.h"
#import "ObjectAL.h"

@interface SquareSoundManager ()

- (id)init;

@end

@implementation SquareSoundManager

+ (SquareSoundManager *)sharedSquareSoundManager {
    static  SquareSoundManager  *singleton = nil;
    if (!singleton) {
        singleton = [[SquareSoundManager alloc] init];
    }
    return singleton;
}


- (id)init {
    if (self = [super init]) {
        [OALSimpleAudio sharedInstance].allowIpod = NO;
        [OALSimpleAudio sharedInstance].honorSilentSwitch = YES;
    }
    return self;
}

- (void)playSound:(NSString *)name {
    [[OALSimpleAudio sharedInstance] playEffect:name];
}

- (void)playBgMusic:(NSString *)music {
    [[OALSimpleAudio sharedInstance] playBg:music loop:YES];
}

- (void)stopBgMusic {
    [[OALSimpleAudio sharedInstance] stopBg];
}

- (void)pauseSounds
{
    [OALSimpleAudio sharedInstance].paused = YES;
}
- (void)unpauseSounds
{
    [OALSimpleAudio sharedInstance].paused = NO;
}

- (void)stop
{
    [[OALSimpleAudio sharedInstance] stopEverything];
}

- (void)setEffectsLevel:(CGFloat)level {
    [[OALSimpleAudio sharedInstance] setEffectsVolume:level];
}

- (void)setMusicLevel:(CGFloat)level {
    [[OALSimpleAudio sharedInstance] setBgVolume:level];
}

- (BOOL)isPlaying {
    return [[OALSimpleAudio sharedInstance] bgPlaying];
}

@end
