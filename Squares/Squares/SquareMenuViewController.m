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

- (void)dealloc {
    [_squareMenuLoop removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _squareMenuLoop = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.squareMainModeButton.layer.borderColor = SQUARE_COLOR_PANE.CGColor;
    self.squareMainModeButton.layer.borderWidth = 1.0f;
    self.squareMainModeButton.titleLabel.font = SQUARE_FONT_MEDIUM;
    [self.squareMainModeButton setTitleColor:SQUARE_COLOR_PANE forState:UIControlStateNormal];
    
    self.squareHardCoreButton.layer.borderColor = SQUARE_COLOR_PANE.CGColor;
    self.squareHardCoreButton.layer.borderWidth = 1.0f;
    self.squareHardCoreButton.titleLabel.font = SQUARE_FONT_MEDIUM;
    [self.squareHardCoreButton setTitleColor:SQUARE_COLOR_PANE forState:UIControlStateNormal];
    
    self.squareOptionsButton.layer.borderColor = SQUARE_COLOR_PANE.CGColor;
    self.squareOptionsButton.layer.borderWidth = 1.0f;
    self.squareOptionsButton.titleLabel.font = SQUARE_FONT_MEDIUM;
    [self.squareOptionsButton setTitleColor:SQUARE_COLOR_PANE forState:UIControlStateNormal];
    
    self.squareCopyright.font = SQUARE_FONT_SMALL;
    
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
        UIView      *popZone = self.squarePopZone2;
                    
        if (value == 0) {
            popZone = self.squarePopZone1;
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

- (IBAction)redirectToGithub:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/Forstulen"]];
}


@end
