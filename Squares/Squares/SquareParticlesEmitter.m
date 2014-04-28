//
//  SquareParticlesEmitter.m
//  Squares
//
//  Created by Romain on 4/27/14.
//
//

#import "SquareParticlesEmitter.h"
#import "SquareBase.h"

@implementation SquareParticlesEmitter

+ (SquareParticlesEmitter *)squareParticlesEmitterWithFrame:(CGRect)rect {
    return [[SquareParticlesEmitter alloc] initWithFrame:rect];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _squareParticlesEmitter = (CAEmitterLayer *)self.layer;
    }
    return self;
}

+ (Class)layerClass
{
    return [CAEmitterLayer class];
}

- (void)startEmitter {
    _squareParticlesEmitter.emitterPosition = CGPointMake(self.frame.size.width / 2,
                                                          self.frame.size.height);
    _squareParticlesEmitter.emitterZPosition = -1;
    _squareParticlesEmitter.emitterSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _squareParticlesEmitter.emitterShape = kCAEmitterLayerLine;
    _squareParticlesEmitter.emitterMode = kCAEmitterLayerSurface;
    _squareParticlesEmitter.renderMode = kCAEmitterLayerAdditive;
    
    CAEmitterCell *emitterCell1 = [CAEmitterCell emitterCell];
    
    emitterCell1.birthRate = 0.3;
    emitterCell1.lifetime = 10;
    emitterCell1.velocity = 0;
    emitterCell1.velocityRange = 20;
    emitterCell1.yAcceleration = -10;
    emitterCell1.emissionRange = 1;
    emitterCell1.scale = 0;
    emitterCell1.scaleSpeed = -0.05;
    emitterCell1.alphaSpeed = -0.05;
    emitterCell1.name = @"cell1";
    emitterCell1.color = [SquareBase randomColor].CGColor;
    emitterCell1.contents = (id)[[UIImage imageNamed:@"ParticleSmoke.png"] CGImage];
    
    CAEmitterCell *emitterCell2 = [CAEmitterCell emitterCell];
    
    emitterCell2.birthRate = 0.3;
    emitterCell2.lifetime = 10;
    emitterCell2.velocity = 0;
    emitterCell2.velocityRange = 20;
    emitterCell2.yAcceleration = -15;
    emitterCell2.emissionRange = 1;
    emitterCell2.scale = 0;
    emitterCell2.scaleSpeed = -0.05;
    emitterCell2.alphaSpeed = -0.05;
    emitterCell2.name = @"cell2";
    emitterCell2.color = [SquareBase randomColor].CGColor;
    emitterCell2.contents = (id)[[UIImage imageNamed:@"ParticleSmoke.png"] CGImage];
    
    CAEmitterCell *emitterCell3 = [CAEmitterCell emitterCell];
    
    emitterCell3.birthRate = 0.3;
    emitterCell3.lifetime = 10;
    emitterCell3.velocity = 0;
    emitterCell3.velocityRange = 20;
    emitterCell3.yAcceleration = -20;
    emitterCell3.emissionRange = 1;
    emitterCell3.scale = 0;
    emitterCell3.scaleSpeed = -0.05;
    emitterCell3.alphaSpeed = -0.05;
    emitterCell3.name = @"cell3";
    emitterCell3.color = [SquareBase randomColor].CGColor;
    emitterCell3.contents = (id)[[UIImage imageNamed:@"ParticleSmoke.png"] CGImage];
    
    _squareParticlesEmitter.emitterCells = [NSArray arrayWithObjects:emitterCell1, emitterCell2, emitterCell3, nil];
}

- (void)pauseEmitter {
    [_squareParticlesEmitter setValue:@0 forKeyPath:@"emitterCells.cell1.birthRate"];
    [_squareParticlesEmitter setValue:@0 forKeyPath:@"emitterCells.cell2.birthRate"];
    [_squareParticlesEmitter setValue:@0 forKeyPath:@"emitterCells.cell3.birthRate"];
}

- (void)unPauseEmitter {
    [_squareParticlesEmitter setValue:@0.3 forKeyPath:@"emitterCells.cell1.birthRate"];
    [_squareParticlesEmitter setValue:@0.3 forKeyPath:@"emitterCells.cell2.birthRate"];
    [_squareParticlesEmitter setValue:@0.3 forKeyPath:@"emitterCells.cell3.birthRate"];
}

- (void)removeEmitter {
    [self removeFromSuperview];
}

@end
