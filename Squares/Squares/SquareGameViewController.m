//
//  SquareGameViewController.m
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import "SquareGameViewController.h"
#import "SquareImage.h"
#import "SquareGrid.h"

@interface SquareGameViewController ()

@end

@implementation SquareGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _squareGrid = [SquareGrid squareGridWithFrame:self.GameBoard.frame withSquareSize:50];
    
    _squareSavedTime = CACurrentMediaTime();
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self
                                              selector:@selector(update:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop]
                      forMode:NSRunLoopCommonModes];
    NSLog(@"%f ",_squareSavedTime);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update:(CADisplayLink*)displayLink {
    [self addSquare];
    [self checkCollisions];
}

- (void)addSquare {
    if (CACurrentMediaTime() - _squareSavedTime > 1) {
        SquareImage *square = [_squareGrid getNewSquare];
    
        [self.GameBoard addSubview:square];
        _squareSavedTime = CACurrentMediaTime();
    }
}

- (void)removeSquare:(CGPoint)touchPoint {
    CALayer *square;
    id  squareDelegate;
    
    touchPoint = [self.GameBoard convertPoint:touchPoint toView:self.GameBoard.superview];
    square = [self.GameBoard.layer.presentationLayer hitTest: touchPoint];
    squareDelegate = [square delegate];
    
    if (squareDelegate != self.GameBoard) {
        for (NSValue *val in _squareGrid.allKeys) {
            if (squareDelegate == [_squareGrid getSquare:val]) {
                [(UIView*)squareDelegate removeFromSuperview];
                [_squareGrid removeSquare:squareDelegate];
                break;
            }
        }
    }
}

- (void)checkCollisions {
    for (SquareImage *rect in _squareGrid.allValues) {
        for (SquareImage *collider in _squareGrid.allValues) {
            if (collider == [NSNull null] || rect == [NSNull null]) {
                continue;
            }
                
            CGRect rect1 = ((CALayer*)rect.layer.presentationLayer).frame;
            CGRect rect2 = ((CALayer*)collider.layer.presentationLayer).frame;

            if (collider != rect && CGRectIntersectsRect(rect1, rect2)) {
                [self pauseLayer:collider.layer];
                [self pauseLayer:rect.layer];
            }
        }
    }
}

- (void) pauseLayer: (CALayer *) theLayer
{
    CFTimeInterval mediaTime = CACurrentMediaTime();
    CFTimeInterval pausedTime = [theLayer convertTime: mediaTime fromLayer: nil];
    theLayer.speed = 0.0;
    theLayer.timeOffset = pausedTime;
}

- (IBAction)tapAction:(id)sender {
 
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    CGPoint touchPoint = [tap locationInView: self.GameBoard];
    
    [self removeSquare:touchPoint];
}

@end
