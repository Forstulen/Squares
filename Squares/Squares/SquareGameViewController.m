//
//  SquareGameViewController.m
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import "SquareGameViewController.h"
#import "SquareBase.h"
#import "defines.h"

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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkScore:) name:SQUARE_DESTROYED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver) name:SQUARE_GAME_OVER object:nil];

    self.GameBoard.multipleTouchEnabled = YES;
    self.view.multipleTouchEnabled = YES;
    

    // DEBUG
    CGFloat realHeight = (self.GameBoard.frame.size.height - ((self.GameBoard.frame.size.height) * SQUARE_GRID_PADDING_PERCENT / 100));
    CGFloat realWidth = (self.GameBoard.frame.size.width - ((self.GameBoard.frame.size.width) * SQUARE_GRID_PADDING_PERCENT / 100));

    CGRect frame = CGRectMake(self.GameBoard.frame.origin.x + (self.GameBoard.frame.size.width - realWidth) / 2.0f, 0 + (self.GameBoard.frame.size.height - realHeight) / 2.0f, realWidth, realHeight);
    UIView *view = [[UIView alloc] initWithFrame:frame];

    view.layer.borderColor = [UIColor greenColor].CGColor;
    view.layer.borderWidth = 2.0f;
    view.multipleTouchEnabled = YES;
    view.userInteractionEnabled = YES;
    
    self.GameBoard.layer.borderColor = [UIColor cyanColor].CGColor;
    self.GameBoard.layer.borderWidth = 2.0f;
    [self.GameBoard addSubview:view];
    //========================
    _squareGrid = [SquareGrid squareGridWithFrame:self.GameBoard.frame];
    _squareGrid.squareGridDelegate = self;
    _squareGameOverViewController = [[SquareGameOverViewController alloc] initWithNibName:NSStringFromClass([SquareGameOverViewController class])  bundle:nil];
    [self initializeGame];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _squareGameOverViewController.squareGameOverViewDelegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeGame {
    _squareSavedTime = CACurrentMediaTime();
    _squareGridEnabled = TRUE;
    _squareScore = 0;
    _squareColorChain = 0;
    _squareBonusMultiplier = 1;
    _squareLastColor = SquareBaseNone;
    [_squareGrid resetValues];

    if (!_squareGameLoop) {
        _squareGameLoop = [CADisplayLink displayLinkWithTarget:self
                                                             selector:@selector(update:)];
        [_squareGameLoop addToRunLoop:[NSRunLoop mainRunLoop]
                              forMode:NSRunLoopCommonModes];
    }
}

- (void)update:(CADisplayLink*)displayLink {
    if (_squareGridEnabled) {
        [self addSquare];
        [self checkCollisions];
    }
}

- (void)addSquare {
    if (CACurrentMediaTime() - _squareSavedTime > SQUARE_GAME_STARTING_RESPAWN_DELAY) {
        [self generateSquare];
        _squareSavedTime = CACurrentMediaTime();
    }
}

// TODO HANDLE THE SQUARE DISTRIBUTION
- (void)generateSquare {
    SquareBase *square = [_squareGrid getNewSquare:SquareTypeExponential];
    
    [self.GameBoard addSubview:square];
    [square beginAnimation];
}

- (void)activateSquareAction:(CGPoint)touchPoint {
    CALayer *square;
    id  squareDelegate;
    
    touchPoint = [self.GameBoard convertPoint:touchPoint toView:self.GameBoard.superview];
    square = [self.GameBoard.layer.presentationLayer hitTest: touchPoint];
    squareDelegate = [square delegate];
    
    if (squareDelegate != self.GameBoard) {
        for (NSValue *val in _squareGrid.allKeys) {
            if (squareDelegate == [_squareGrid getSquare:val]) {
                [_squareGrid activateSquareAction:squareDelegate];
                [self generateSquare];
                break;
            }
        }
    }
}
- (void)restartGame {
    [UIView animateWithDuration:SQUARE_GAME_RESTART_DELAY animations:^() {
        for (SquareBase *subview in _squareGrid.allValues) {
            if ((id)subview != [NSNull null]) {
                [subview endAnimation];
                [subview unPauseAnimation];
            }
        }
    }
                     completion:^(BOOL finished) {
                         [self initializeGame];
                     }];
}

- (void)quitGame {
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)gameOver {
    _squareGridEnabled = FALSE;
    for (SquareBase *image in _squareGrid.allValues) {
        if ((id)image != [NSNull null]) {
            [image pauseAnimation];
        }
    }
    _squareGameOverViewController.squareGameOverViewDelegate = self;
    _squareGameOverViewController.squareScore.text = [NSString stringWithFormat:@"%lu", (unsigned long)_squareScore];
    [_squareGameOverViewController presentAnimatedGameOverView:self.view withCompletion:nil];
}

- (void)checkCollisions {
    for (SquareBase *rect in _squareGrid.allValues) {
        for (SquareBase *collider in _squareGrid.allValues) {
            if ((id)collider == [NSNull null] || (id)rect == [NSNull null]) {
                continue;
            }
                
            CGRect rect1 = ((CALayer*)rect.layer.presentationLayer).frame;
            CGRect rect2 = ((CALayer*)collider.layer.presentationLayer).frame;
            
            if (!CGRectEqualToRect(rect1, rect2) && collider != rect && CGRectIntersectsRect(rect1, rect2)) {
                rect.layer.borderColor = [UIColor purpleColor].CGColor;
                rect.layer.borderWidth = 3.0f;
                collider.layer.borderColor = [UIColor purpleColor].CGColor;
                collider.layer.borderWidth = 3.0f;
                [self gameOver];
                break;
            }
        }
    }
}

- (void)checkScore:(NSNotification *)notification {
    SquareBase  *square = notification.object;
    
    _squareScore += square.squareScore;
    
    if (square.squareColor == _squareLastColor) {
        ++_squareColorChain;
    } else {
        _squareColorChain = 0;
    }
    _squareLastColor = square.squareColor;
    _squareScore += (_squareColorChain / SQUARE_GAME_MIN_CHAIN_NUMBER) * _squareBonusMultiplier * SQUARE_GAME_BONUS_CHAIN;
    self.Score.text = [NSString stringWithFormat:@"%lu", (unsigned long)_squareScore];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSSet* touchSet = [event allTouches];
    NSLog(@"TOUCH %d", [event allTouches].count);
    for (UITouch *touch in touchSet) {
        CGPoint touchPoint = [touch locationInView: self.GameBoard];
        
        if (_squareGridEnabled) {
            [self activateSquareAction:touchPoint];
        }
    }
}

@end
