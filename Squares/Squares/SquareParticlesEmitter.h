//
//  SquareParticlesEmitter.h
//  Squares
//
//  Created by Romain on 4/27/14.
//
//

#import <Foundation/Foundation.h>

@interface SquareParticlesEmitter : UIView {
    CAEmitterLayer  *_squareParticlesEmitter;
}

+ (SquareParticlesEmitter *)squareParticlesEmitterWithFrame:(CGRect)rect;

- (void)startEmitter;
- (void)pauseEmitter;
- (void)unPauseEmitter;
- (void)removeEmitter;

@end
