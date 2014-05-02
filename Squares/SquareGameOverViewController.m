//
//  SquareGameOverViewController.m
//  Squares
//
//  Created by Romain on 4/6/14.
//
//

#import "UIImage+UIImageAdditions.h"
#import "SquareGameOverViewController.h"
#import "SquareSocialController.h"
#import "SquareScoreManager.h"
#import "SquareSoundManager.h"
#import "defines.h"

@interface SquareGameOverViewController ()

@end

@implementation SquareGameOverViewController

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

    self.squareTitle.font = SQUARE_FONT_MEDIUM;
    self.squareScore.font = SQUARE_FONT_BIG;
    self.squareBestScoreTitle.font = SQUARE_FONT_MEDIUM;
    self.squareBestScore.font = SQUARE_FONT_BIG;
    
    
    self.squareTryAgainButton.layer.borderColor = SQUARE_COLOR_PANE.CGColor;
    self.squareTryAgainButton.layer.borderWidth = 1.0f;
    self.squareTryAgainButton.titleLabel.font = SQUARE_FONT_MEDIUM;
    [self.squareTryAgainButton setTitleColor:SQUARE_COLOR_PANE forState:UIControlStateNormal];
    self.squareTryAgainButton.titleLabel.backgroundColor = [UIColor clearColor];
    
    self.squareQuitButton.layer.borderColor = SQUARE_COLOR_PANE.CGColor;
    self.squareQuitButton.layer.borderWidth = 1.0f;
    self.squareQuitButton.titleLabel.font = SQUARE_FONT_MEDIUM;
    [self.squareQuitButton setTitleColor:SQUARE_COLOR_PANE forState:UIControlStateNormal];
    [self.squareQuitButton setBackgroundImage:nil forState:UIControlStateNormal];
    self.squareQuitButton.titleLabel.backgroundColor = [UIColor clearColor];
    
    _squareActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _squareActivityIndicator.frame = self.view.frame;
    [self.view addSubview:_squareActivityIndicator];
    _squareActivityIndicator.hidesWhenStopped = YES;
    [SquareSocialController sharedSquareSocialController].squareDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startRequest {
    [_squareActivityIndicator startAnimating];
    self.squareFacebookButton.enabled = NO;
}

- (void)stopRequest {
    [_squareActivityIndicator stopAnimating];
    self.squareFacebookButton.enabled = YES;
}
     
- (IBAction)postScoreOnFacebook:(id)sender {
    [[SquareSoundManager sharedSquareSoundManager] playSound:SQUARE_SOUND_CLICK];
    SquareLevelsManager *levelsManager = [SquareLevelsManager sharedSquareLevelsManager];
    
    [[SquareSocialController sharedSquareSocialController] postOnFacebook:levelsManager.squareGameType withScore:self.squareScore.text.integerValue];
}

- (IBAction)restartGame:(id)sender {
    [[SquareSoundManager sharedSquareSoundManager] playSound:SQUARE_SOUND_CLICK];
    [self dismissAnimatedGameOverView:self.view.superview withCompletion:^(BOOL finished) {
        [self.view removeFromSuperview];
        if (self.squareGameOverViewDelegate)
            [self.squareGameOverViewDelegate restartGame];
    }];
}

- (IBAction)quitGame:(id)sender {
    [[SquareSoundManager sharedSquareSoundManager] playSound:SQUARE_SOUND_CLICK];
    [self dismissAnimatedGameOverView:self.view.superview withCompletion:^(BOOL finished) {
        [self.view removeFromSuperview];
        if (self.squareGameOverViewDelegate)
            [self.squareGameOverViewDelegate quitGame];
    }];
}

- (void)presentAnimatedGameOverView:(UIView *)parent withCompletion:(void (^)(BOOL))block {
    NSInteger   viewHeight = parent.frame.size.height;

    self.view.frame = CGRectMake(0, viewHeight, parent.frame.size.width, parent.frame.size.height);
    [parent addSubview:self.view];

    SquareScoreManager *scoreManager = [SquareScoreManager sharedSquareScoreManager];
    
    self.squareScore.text = [NSString stringWithFormat:@"%lu", (unsigned long)scoreManager.squareScore];
    self.squareBestScore.text = [NSString stringWithFormat:@"%lu", (unsigned long)[scoreManager getCorrespondingBestScore]];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:block];
}

- (void)dismissAnimatedGameOverView:(UIView *)parent withCompletion:(void (^)(BOOL))block {
    NSInteger   viewHeight = parent.frame.size.height;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.frame = CGRectMake(0, viewHeight, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:block];
}

@end
