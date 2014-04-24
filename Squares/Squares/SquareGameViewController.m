//
//  SquareGameViewController.m
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import "SquareGameViewController.h"
#import "SquareScoreManager.h"
#import "SquareCounter.h"
#import "SquareExplosion.h"
#import "SquareMultiplier.h"
#import "SquareLevels.h"
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver) name:SQUARE_GAME_OVER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayMultiplier:) name:SQUARE_MULTIPLIER object:nil];
    

    self.GameBoard.multipleTouchEnabled = YES;
    self.view.multipleTouchEnabled = YES;
    self.Score.font = SQUARE_FONT_HUGE;
    self.squareMultiplier.font = SQUARE_FONT_HUGE;
    self.squarePauseLabel.font = SQUARE_FONT_HUGE;
    self.squarePauseButton.enabled = NO;
    
    // DEBUG
    CGFloat realHeight = (self.GameBoard.frame.size.height - ((self.GameBoard.frame.size.height) * SQUARE_GRID_PADDING_PERCENT / 100));
    CGFloat realWidth = (self.GameBoard.frame.size.width - ((self.GameBoard.frame.size.width) * SQUARE_GRID_PADDING_PERCENT / 100));

    CGRect frame = CGRectMake(self.GameBoard.frame.origin.x + (self.GameBoard.frame.size.width - realWidth) / 2.0f, 0 + (self.GameBoard.frame.size.height - realHeight) / 2.0f, realWidth, realHeight);
    UIView *view = [[UIView alloc] initWithFrame:frame];

    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = 0.5f;
    view.multipleTouchEnabled = YES;
    view.userInteractionEnabled = YES;
    [self.GameBoard addSubview:view];
    //========================
    
    _squareGrid = [SquareGrid squareGridWithFrame:self.GameBoard.frame];
    _squareGameOverViewController = [[SquareGameOverViewController alloc] initWithNibName:NSStringFromClass([SquareGameOverViewController class])  bundle:nil];
    
    [self countdownBeforeGame];
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

- (void)countdownBeforeGame {
    SquareCounter   *counter = [[SquareCounter alloc] initWithParent:self.GameBoard];
    
    [counter startCounter:3];
    [self performSelector:@selector(initializeGame) withObject:nil afterDelay:3];
}

- (void)initializeGame {
    _squareGridEnabled = TRUE;
    self.squarePauseButton.enabled = YES;
    [_squareGrid resetValues];
    [[SquareScoreManager sharedSquareScoreManager] resetScore];
    [[SquareLevelsManager sharedSquareLevelsManager] resetLevel];
    if (!_squareGameLoop) {
        _squareGameLoop = [CADisplayLink displayLinkWithTarget:self
                                                             selector:@selector(update:)];
        [_squareGameLoop addToRunLoop:[NSRunLoop mainRunLoop]
                              forMode:NSRunLoopCommonModes];
    }
    
    _squareElapsedTime = CACurrentMediaTime();
    _squareLastSpawnTime = CACurrentMediaTime();
    _squareLastActivityTime = CACurrentMediaTime();
    _squareLastLevelTime = CACurrentMediaTime();
    _squareLastRefreshTime = CACurrentMediaTime();
}

- (IBAction)pause:(id)sender {
    _squareGridEnabled = !_squareGridEnabled;
    for (SquareBase *image in _squareGrid.allValues) {
        if ((id)image != [NSNull null]) {
            if (!_squareGridEnabled) {
                [image pauseAnimation];
                self.squarePauseLabel.hidden = NO;
            } else {
                [image unPauseAnimation];
                self.squarePauseLabel.hidden = YES;
            }
        }
    }
}

- (void)update:(CADisplayLink*)displayLink {
    
    _squareElapsedTime = CACurrentMediaTime() - _squareElapsedTime;
    
    if (_squareGridEnabled) {
        [self checkLevel];
        [self checkSquare];
        [self checkCollisions];
        [self checkScore];
    }
}

- (void)configureGameMode:(SquareGameType)type {
    [[SquareLevelsManager sharedSquareLevelsManager] setGameType:type];
    [[SquareScoreManager sharedSquareScoreManager] setGameType:type];
}

- (void)addRandomSquare {
    NSDictionary *squares = [[SquareLevelsManager sharedSquareLevelsManager] squareAvailableItems];
    NSInteger randomNumber = arc4random() % 100;
    NSUInteger count = 0;
    
    for (NSString *squareType in squares.allKeys) {
        count += [[squares objectForKey:squareType] integerValue];
        if (count > randomNumber) {
            SquareBase *square = [_squareGrid getNewSquare:[SquareGrid squareTypeStringToEnum:squareType]];
            
            [self.GameBoard addSubview:square];
            [square beginAnimation];
            break;
        }
    }
}

- (void)displayMultiplier:(NSNotification *)notification {
    NSNumber  *multiplier = notification.object;
    
    [SquareMultiplier squareMultiplierWithParent:self.GameBoard withNumber:multiplier.integerValue withPosition:_squareLastPositionKnow];
}


- (void)checkLevel {
    SquareLevelsManager *levelManager = [SquareLevelsManager sharedSquareLevelsManager];
    
    if (levelManager.squareNextLevel != -1 && (CACurrentMediaTime() - _squareLastLevelTime) > levelManager.squareNextLevel) {
        [levelManager setNextLevel];
        _squareLastLevelTime = CACurrentMediaTime();
    }
}

- (void)checkSquare {
    SquareLevelsManager *levelsManager = [SquareLevelsManager sharedSquareLevelsManager];
    
    // SQUARE NUMBER
    if ((CACurrentMediaTime() - _squareLastRefreshTime) > levelsManager.squareRefreshDelay && levelsManager.
        squareSquareNumber != -1 && _squareGrid.squareNumber < levelsManager.squareSquareNumber) {
        for (NSUInteger i = _squareGrid.squareNumber; i < levelsManager.squareSquareNumber; ++i) {
            [self addRandomSquare];
        }
        _squareLastRefreshTime = CACurrentMediaTime();
    }

    // SQUARE AUTO RESPAWN
    if (levelsManager.squareSpawnDelay != -1 && (CACurrentMediaTime() - _squareLastSpawnTime) > levelsManager.squareSpawnDelay) {
        [self addRandomSquare];
        _squareLastSpawnTime = CACurrentMediaTime();
    }
    
    // SQUARE INACTIVITY
    if (levelsManager.squareInactivityDelay != -1 && (CACurrentMediaTime() - _squareLastActivityTime) > levelsManager.squareInactivityDelay) {
        [self addRandomSquare];
        _squareLastActivityTime = CACurrentMediaTime();
    }
}

- (void)activateSquareAction:(CGPoint)touchPoint {
    CALayer *square;
    id  squareDelegate;
    
    touchPoint = [self.GameBoard convertPoint:touchPoint toView:self.GameBoard.superview];
    square = [self.GameBoard.layer.presentationLayer hitTest: touchPoint];
    squareDelegate = [square delegate];
    
    for (NSValue *val in _squareGrid.allKeys) {
        if (squareDelegate == [_squareGrid getSquare:val]) {
            [_squareGrid activateSquareAction:squareDelegate];
            return;
        }
    }
    [[SquareScoreManager sharedSquareScoreManager] resetMultiplier];
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
                         [self countdownBeforeGame];
                     }];
}

- (void)quitGame {
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)gameOver {
    _squareGridEnabled = NO;
    self.squarePauseButton.enabled = NO;
    for (SquareBase *image in _squareGrid.allValues) {
        if ((id)image != [NSNull null]) {
            [image pauseAnimation];
        }
    }
    _squareGameOverViewController.squareGameOverViewDelegate = self;
    [_squareGameOverViewController presentAnimatedGameOverView:self.view withCompletion:nil];
}

- (void)checkScore {
    SquareScoreManager *scoreManager =  [SquareScoreManager sharedSquareScoreManager];
    
    self.squareMultiplier.text = [NSString stringWithFormat:@"X%lu", (unsigned long)scoreManager.squareBonusMultiplier];
    self.Score.text = [NSString stringWithFormat:@"%lu", (unsigned long)scoreManager.squareScore];
}

- (void)checkCollisions {
    for (SquareBase *rect in _squareGrid.allValues) {
        for (SquareBase *collider in _squareGrid.allValues) {
            if ((id)collider == [NSNull null] || (id)rect == [NSNull null]) {
                continue;
            }
                
            CGRect rect1 = ((CALayer*)rect.layer.presentationLayer).frame;
            CGRect rect2 = ((CALayer*)collider.layer.presentationLayer).frame;
        
            if (CGRectEqualToRect(rect1, CGRectZero) || CGRectEqualToRect(rect2, CGRectZero)) {
                continue;
            }
            
            if (!CGRectEqualToRect(rect1, rect2) &&
                collider != rect &&
                CGRectIntersectsRect(rect1, rect2)) {
                CGRect intersection = CGRectIntersection(rect1, rect2);
                SquareExplosion *explosion1 = [[SquareExplosion alloc] initWithFrame:intersection];
                
                [self.GameBoard addSubview:explosion1];
                [explosion1 startExplosion:intersection withColor:SQUARE_COLOR_PANE];
                [self gameOver];
                break;
            }
        }
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSSet* touchSet = [event allTouches];
    _squareLastActivityTime = CACurrentMediaTime();
    for (UITouch *touch in touchSet) {
        _squareLastPositionKnow = [touch locationInView: self.GameBoard];
        
        if (_squareGridEnabled) {
            
            [self activateSquareAction:_squareLastPositionKnow];
        }
    }
}

@end
