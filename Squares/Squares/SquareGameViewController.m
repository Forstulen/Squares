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
#import "SquareSoundManager.h"
#import "SquareIndicatorLevel.h"
#import "SquareMultiplier.h"
#import "SquareParticlesEmitter.h"
#import "SquareCrossedLines.h"
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayMultiplier:) name:SQUARE_MULTIPLIER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bestScoreEver) name:SQUARE_BEST_SCORE_EVER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkScore) name:SQUARE_UPDATE_SCORE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pause:) name:SQUARE_PAUSE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetMultiplier) name:SQUARE_MULTIPLIER_RESET object:nil];
    

    
    self.GameBoard.multipleTouchEnabled = YES;
    self.view.multipleTouchEnabled = YES;
    self.Score.font = SQUARE_FONT_BIG;
    self.squareMultiplier.font = SQUARE_FONT_BIG ;
    self.squarePauseLabel.font = SQUARE_FONT_HUGE;
    self.squarePauseHint.font = SQUARE_FONT_BIG;
    self.squarePauseButton.enabled = NO;
    
    self.Score.layer.borderColor = [UIColor whiteColor].CGColor;
    self.Score.layer.borderWidth = 2.0f;
    
    self.squareMultiplier.layer.borderColor = [UIColor whiteColor].CGColor;
    self.squareMultiplier.layer.borderWidth = 1.0f;
    
    self.GameBoard.layer.borderColor = [UIColor whiteColor].CGColor;
    self.GameBoard.layer.borderWidth = 1.0f;
    self.GameBoard.multipleTouchEnabled = YES;
    self.GameBoard.userInteractionEnabled = YES;
    
    _squareGameOverViewController = [[SquareGameOverViewController alloc] initWithNibName:NSStringFromClass([SquareGameOverViewController class])  bundle:nil];
    [[SquareSoundManager sharedSquareSoundManager] stopBgMusic];
}

- (void)viewDidLayoutSubviews {
    if (_squareGrid == nil) {
        _squareGrid = [SquareGrid squareGridWithFrame:self.GameBoard.frame];
        _squareParticlesEmitter = [SquareParticlesEmitter squareParticlesEmitterWithFrame:self.view.frame];
        [self.GameBoard insertSubview:_squareParticlesEmitter atIndex:0];
        
        [self countdownBeforeGame];
    }
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
    
    [[SquareSoundManager sharedSquareSoundManager] playBgMusic:SQUARE_MUSIC_INGAME];
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
        [_squareGameLoop setFrameInterval:SQUARE_FRAME_INTERVAL];
        [_squareGameLoop addToRunLoop:[NSRunLoop mainRunLoop]
                              forMode:NSRunLoopCommonModes];
    }
    _squareGameLoop.paused = NO;
    
    if (IS_RETINA)
        [_squareParticlesEmitter startEmitter];
    
    _squareElapsedTime = CACurrentMediaTime();
    _squareLastSpawnTime = CACurrentMediaTime();
    _squareLastActivityTime = CACurrentMediaTime();
    _squareLastLevelTime = CACurrentMediaTime();
    _squareLastRefreshTime = CACurrentMediaTime();
    _squarePauseTime = CACurrentMediaTime();
    _squareLastBackGroundLinesTime = CACurrentMediaTime();
    
    SquareLevelsManager *levelManager = [SquareLevelsManager sharedSquareLevelsManager];
    
    if (_squareGameType == SquareLevelsHardcore) {
        [SquareIndicatorLevel squareIndicatorLevelWithParent:self.GameBoard withMessage:[NSString stringWithFormat:@"%@\n\n%@", SQUARE_LEVELS_HARDCORE, levelManager.squareLevelDetail]];
    } else {
        [SquareIndicatorLevel squareIndicatorLevelWithParent:self.GameBoard withMessage:[NSString stringWithFormat:@"%@\n\n%@", SQUARE_LEVELS_TRAINING, levelManager.squareLevelDetail]];
    }
}

- (IBAction)pause:(id)sender {
    _squareGridEnabled = !_squareGridEnabled;
    for (SquareBase *image in _squareGrid.allValues) {
        if ((id)image != [NSNull null]) {
            if (!_squareGridEnabled) {
                [image pauseAnimation];
                self.squarePauseLabel.hidden = NO;
                [_squareParticlesEmitter pauseEmitter];
            } else {
                [image unPauseAnimation];
                self.squarePauseLabel.hidden = YES;
                [_squareParticlesEmitter unPauseEmitter];
            }
        }
    }
}

- (void)update:(CADisplayLink*)displayLink {
    @autoreleasepool {
        if (_squareGridEnabled) {
            _squareElapsedTime = CACurrentMediaTime() - _squarePauseTime;
        
            [self checkLevel];
            [self checkSquare];
            [self checkCollisions];
            if (IS_RETINA)
                [self checkBackgroundEffects];
        } else {
            _squarePauseTime = CACurrentMediaTime() - _squareElapsedTime;
        }
    }
}

- (void)configureGameMode:(SquareGameType)type {
    _squareGameType = type;
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
    
    [[SquareSoundManager sharedSquareSoundManager] playSound:SQUARE_SOUND_MULTIPLIER];
    [SquareMultiplier squareMultiplierWithParent:self.GameBoard withMessage:[NSString stringWithFormat:@"X%lu", (unsigned long)multiplier.integerValue] withPosition:_squareLastPositionKnow];
}

- (void)checkBackgroundEffects {
    if (CACurrentMediaTime() - _squareLastBackGroundLinesTime > SQUARE_DELAY_GAME_LINES_GAME + arc4random() % SQUARE_DELAY_GAME_LINES_MARGIN_PERCENT) {
        [SquareCrossedLines squareCrossedLinesWithFrame:self.view.frame withParent:self.GameBoard];
        
        _squareLastBackGroundLinesTime = CACurrentMediaTime();
    }
}

- (void)checkLevel {
    SquareLevelsManager *levelManager = [SquareLevelsManager sharedSquareLevelsManager];
    
    if (levelManager.squareNextLevel != -1 && _squareElapsedTime > levelManager.squareNextLevel) {
        [levelManager setNextLevel];
        _squareLastLevelTime = _squareElapsedTime;
        
        [SquareIndicatorLevel squareIndicatorLevelWithParent:self.GameBoard withMessage:[NSString stringWithFormat:@"Level %d\n\n%@", levelManager.squareCurrentIndex, levelManager.squareLevelDetail]];
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
    if (squareDelegate != nil) {
        if ([SquareScoreManager sharedSquareScoreManager].squareBonusMultiplier > 1) {
            [self resetMultiplier];
        }
    }
}

- (void)resetMultiplier {
    [SquareMultiplier squareMultiplierWithParent:self.GameBoard withMessage:SQUARE_MULTIPLIER_RESET withPosition:_squareLastPositionKnow];
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
    [_squareGameLoop removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _squareGameLoop = nil;
    
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
    _squareGameLoop.paused = YES;
    [_squareParticlesEmitter pauseEmitter];
    [[SquareSoundManager sharedSquareSoundManager] stopBgMusic];
    [[SquareSoundManager sharedSquareSoundManager] playSound:SQUARE_SOUND_GAMEOVER];
    _squareGameOverViewController.squareGameOverViewDelegate = self;
    [_squareGameOverViewController presentAnimatedGameOverView:self.view withCompletion:nil];
}

- (void)bestScoreEver {
    [self gameOver];
    self.Score.text = SQUARE_PGM;
    self.squareMultiplier.text = SQUARE_STUNNING;
}

- (void)checkScore {
    SquareScoreManager *scoreManager =  [SquareScoreManager sharedSquareScoreManager];
    
    self.squareMultiplier.text = [NSString stringWithFormat:@"X%lu", (unsigned long)scoreManager.squareBonusMultiplier];
    self.Score.text = [NSString stringWithFormat:@"%lu", (unsigned long)scoreManager.squareScore];
}

- (void)checkCollisions {
    NSArray *squares = _squareGrid.allValues;
    
    for (SquareBase *rect in squares) {
        for (SquareBase *collider in squares) {
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
                
                intersection.size.width = 150;
                intersection.size.height = intersection.size.width;
                
                SquareExplosion *explosion = [[SquareExplosion alloc] initWithFrame:intersection];
                
                [self.GameBoard addSubview:explosion];
                [explosion startExplosion:intersection withColor:[SquareBase randomColor]];
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
