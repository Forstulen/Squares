//
//  SquareOptionsViewController.m
//  Squares
//
//  Created by Romain on 4/25/14.
//
//

#import "UIImage+UIImageAdditions.h"
#import "SquareOptionsViewController.h"
#import "SquareCrossedLines.h"
#import "SquareSoundManager.h"
#import "defines.h"

@interface SquareOptionsViewController ()

@end

@implementation SquareOptionsViewController

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

    self.squareSoundsLabel.font = SQUARE_FONT_MEDIUM;
    self.squareSoundsLabel.textColor = SQUARE_COLOR_PANE;
    self.squareMusicLabel.font = SQUARE_FONT_MEDIUM;
    self.squareMusicLabel.textColor = SQUARE_COLOR_PANE;
    
    self.squareDoneButton.layer.borderColor = SQUARE_COLOR_PANE.CGColor;
    self.squareDoneButton.layer.borderWidth = 1.0f;
    self.squareDoneButton.titleLabel.font = SQUARE_FONT_MEDIUM;
    [self.squareDoneButton setTitleColor:SQUARE_COLOR_PANE forState:UIControlStateNormal];
    
    [self loadOptions];
    
    if (!_squareMenuLoop) {
        _squareMenuLoop = [CADisplayLink displayLinkWithTarget:self
                                                      selector:@selector(update:)];
        [_squareMenuLoop setFrameInterval:SQUARE_FRAME_INTERVAL];
        [_squareMenuLoop addToRunLoop:[NSRunLoop mainRunLoop]
                              forMode:NSRunLoopCommonModes];
    }
    _squareElapsedTime = CACurrentMediaTime();
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _squareMenuLoop.paused = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _squareMenuLoop.paused = YES;
}

- (void)update:(CADisplayLink*)displayLink {
    [self displayLines];
}

- (void)displayLines {
    if (CACurrentMediaTime() - _squareElapsedTime > SQUARE_DELAY_GAME_LINES_MENU) {
        [SquareCrossedLines squareCrossedLinesWithFrame:self.squareLinesZone.frame withParent:self.squareLinesZone];
        
        _squareElapsedTime = CACurrentMediaTime();
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)soundChanged:(id)sender {
    [[SquareSoundManager sharedSquareSoundManager] setEffectsLevel:self.squareSoundSlider.value];
}


- (IBAction)musicChanged:(id)sender {
    [[SquareSoundManager sharedSquareSoundManager] setMusicLevel:self.squareMusicSlider.value];
}


- (IBAction)validateOptions:(id)sender {
    [[self navigationController] popToRootViewControllerAnimated:YES];
    [self saveOptions];
}


- (void)loadOptions {
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults floatForKey:SQUARE_OPTIONS_SOUND]) {
        [self.squareSoundSlider setValue:[defaults floatForKey:SQUARE_OPTIONS_SOUND] animated:NO];
    }
    
    if ([defaults floatForKey:SQUARE_OPTIONS_MUSIC]) {
        [self.squareMusicSlider setValue:[defaults floatForKey:SQUARE_OPTIONS_MUSIC] animated:NO];
    }
}

- (void)saveOptions {
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setFloat:self.squareSoundSlider.value forKey:SQUARE_OPTIONS_SOUND];
    [defaults setFloat:self.squareMusicSlider.value forKey:SQUARE_OPTIONS_MUSIC];
    [defaults synchronize];
}

@end
