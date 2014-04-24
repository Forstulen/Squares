//
//  SquareExplosion.m
//  Squares
//
//  Created by Romain on 4/24/14.
//
//

#import "UIImage+UIImageAdditions.h"
#import "SquareExplosion.h"
#import "defines.h"

@implementation SquareExplosion


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _squareExplosionEmitter = (CAEmitterLayer *)self.layer;
    }
    return self;
}

+ (Class)layerClass
{
    return [CAEmitterLayer class];
}

- (void)startExplosion:(CGRect)frame withColor:(UIColor *)color {
    [self performSelector:@selector(disableExplosion) withObject:nil afterDelay:0.1];
    [self performSelector:@selector(removeExplosion) withObject:nil afterDelay:1.0];
    
    
    _squareExplosionEmitter.emitterPosition = CGPointMake(frame.size.width / 2, frame.size.height /2);
    _squareExplosionEmitter.emitterZPosition = 10;
    _squareExplosionEmitter.emitterSize = CGSizeMake(frame.size.width, frame.size.height);
    _squareExplosionEmitter.emitterShape = kCAEmitterLayerRectangle;
    _squareExplosionEmitter.emitterMode = kCAEmitterLayerOutline;
    _squareExplosionEmitter.renderMode = kCAEmitterLayerAdditive;
    
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];

    emitterCell.birthRate = 75;
    emitterCell.lifetime = 0.5;
    emitterCell.velocity = 100;
    emitterCell.velocityRange = 20;
    emitterCell.xAcceleration = 500 * arc4random() % 2 ? 1 : -1;
    emitterCell.yAcceleration = 500 * arc4random() % 2 ? 1 : -1;
    emitterCell.emissionRange = 0.8;
    emitterCell.scale = 0;
    emitterCell.scaleSpeed = 0.3;
    emitterCell.alphaSpeed = -3;
    emitterCell.name = @"cell";
    emitterCell.color = [color CGColor];
    emitterCell.contents = (id)[[UIImage imageNamed:@"particle_base-48x48.jpg"] CGImage];
    
    _squareExplosionEmitter.emitterCells = [NSArray arrayWithObject:emitterCell];
}

- (void)disableExplosion {
    [_squareExplosionEmitter setValue:@0 forKeyPath:@"emitterCells.cell.birthRate"];
}

- (void)removeExplosion {
    [self removeFromSuperview];
}

@end
