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
#import "SquareSoundManager.h"
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
        [_squareMenuLoop addToRunLoop:[NSRunLoop mainRunLoop]
                              forMode:NSRunLoopCommonModes];
    }
    _squareElapsedTime = CACurrentMediaTime() - SQUARE_DELAY_MENU_SQUARE;
}

- (void)update:(CADisplayLink*)displayLink {
    [self displayRandomSquare];
}

- (void)displayRandomSquare {
    if (CACurrentMediaTime() - _squareElapsedTime > SQUARE_DELAY_MENU_SQUARE) {
        SquareDemo  *demo = [SquareDemo squareDemoWithPosition:];
   
        _squareElapsedTime = CACurrentMediaTime();
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

@end
