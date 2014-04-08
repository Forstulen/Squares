//
//  SquareGameView.m
//  Squares
//
//  Created by Romain on 4/8/14.
//
//

#import "SquareGameView.h"

@implementation SquareGameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"TOUCH %d", [event allTouches].count);
}

@end
