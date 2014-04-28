//
//  SquareMenuViewController.m
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import "UIImage+UIImageAdditions.h"
#import "SquareMenuViewController.h"
#import "SquareGameViewController.h"
#import "SquareOptionsViewController.h"
#import "SquareCrossedLines.h"
#import "SquareSoundManager.h"
#import "SquareParticlesEmitter.h"
#import "SquareDemo.h"
#import "defines.h"

@interface SquareMenuViewController ()

@end

@implementation SquareMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.squareMainModeButton setBackgroundImage:[UIImage imageNamed:SQUARE_SMALL_BUTTON withColor:SQUARE_COLOR_CYAN] forState:UIControlStateNormal];
    self.squareMainModeButton.titleLabel.font = SQUARE_FONT_MEDIUM;
    self.squareMainModeButton.titleLabel.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.squareMainModeButton.titleLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    self.squareMainModeButton.titleLabel.layer.shadowRadius = 10.0;
    self.squareMainModeButton.titleLabel.layer.shadowOpacity = 0.3;
    self.squareMainModeButton.titleLabel.layer.masksToBounds = NO;
    
    [self.squareMainModeButton setTitleColor:SQUARE_COLOR_CYAN forState:UIControlStateNormal];
    
    [self.squareHardCoreButton setBackgroundImage:[UIImage imageNamed:SQUARE_SMALL_BUTTON withColor:SQUARE_COLOR_ORANGE] forState:UIControlStateNormal];
    self.squareHardCoreButton.titleLabel.font = SQUARE_FONT_MEDIUM;
    [self.squareHardCoreButton setTitleColor:SQUARE_COLOR_ORANGE forState:UIControlStateNormal];
    
    [self.squareOptionsButton setBackgroundImage:[UIImage imageNamed:SQUARE_SMALL_BUTTON withColor:SQUARE_COLOR_YELLOW] forState:UIControlStateNormal];
    self.squareOptionsButton.titleLabel.font = SQUARE_FONT_MEDIUM;
    [self.squareOptionsButton setTitleColor:SQUARE_COLOR_YELLOW forState:UIControlStateNormal];
    
    if (!_squareMenuLoop) {
        _squareMenuLoop = [CADisplayLink displayLinkWithTarget:self
                                                      selector:@selector(update:)];
        [_squareMenuLoop setFrameInterval:SQUARE_FRAME_INTERVAL];
        [_squareMenuLoop addToRunLoop:[NSRunLoop mainRunLoop]
                              forMode:NSRunLoopCommonModes];
    }
    _squareElapsedTime = CACurrentMediaTime();
    _squareElapsedTimeDemo = CACurrentMediaTime();
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (![SquareSoundManager sharedSquareSoundManager].isPlaying) {
        [[SquareSoundManager sharedSquareSoundManager] playBgMusic:SQUARE_MUSIC_AMBIENT];
    }
    _squareMenuLoop.paused = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _squareMenuLoop.paused = YES;
}

- (void)update:(CADisplayLink*)displayLink {
    [self displayLines];
    [self displaySquares];
}

- (void)displayLines {
    if (CACurrentMediaTime() - _squareElapsedTime > SQUARE_DELAY_GAME_LINES_MENU) {
        [SquareCrossedLines squareCrossedLinesWithFrame:self.squarePopZone.frame withParent:self.squarePopZone];
        
        _squareElapsedTime = CACurrentMediaTime();
    }
}

- (void)displaySquares {
    if (CACurrentMediaTime() - _squareElapsedTimeDemo > SQUARE_DELAY_MENU_SQUARE) {
        NSInteger   value = arc4random() % 3;
        UIView      *popZone = self.squarePopZone3;
                    
        if (value == 0) {
            popZone = self.squarePopZone1;
        } else if (value == 1) {
            popZone = self.squarePopZone2;
        }
        CGPoint point = CGPointMake(arc4random() % (int)popZone.frame.size.width,
                                    arc4random() % (int)popZone.frame.size.height);
        
        [popZone addSubview:[SquareDemo squareDemoWithPosition:point]];
        
        _squareElapsedTimeDemo = CACurrentMediaTime();
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)launchGameView:(id)sender {
    SquareGameViewController *gameController = [[SquareGameViewController alloc] initWithNibName:NSStringFromClass([SquareGameViewController class]) bundle:nil];
    [[SquareSoundManager sharedSquareSoundManager] playSound:SQUARE_SOUND_CLICK];
    [gameController configureGameMode:SquareLevelsPlay];
    [[self navigationController] pushViewController:gameController animated:NO];
}


- (IBAction)launchHardCoreGameView:(id)sender {
    SquareGameViewController *gameController = [[SquareGameViewController alloc] initWithNibName:NSStringFromClass([SquareGameViewController class]) bundle:nil];
    
    [[SquareSoundManager sharedSquareSoundManager] playSound:SQUARE_SOUND_CLICK];
    [gameController configureGameMode:SquareLevelsHardcore];
    [[self navigationController] pushViewController:gameController animated:NO];
}


- (IBAction)launchOptions:(id)sender {
    SquareOptionsViewController *optionController = [[SquareOptionsViewController alloc] initWithNibName:NSStringFromClass([SquareOptionsViewController class]) bundle:nil];
    
    [[SquareSoundManager sharedSquareSoundManager] playSound:SQUARE_SOUND_CLICK];
    [[self navigationController] pushViewController:optionController animated:NO];
}

@end
