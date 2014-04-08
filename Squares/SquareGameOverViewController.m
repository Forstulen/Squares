//
//  SquareGameOverViewController.m
//  Squares
//
//  Created by Romain on 4/6/14.
//
//

#import "SquareGameOverViewController.h"

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)restartGame:(id)sender {
    [self dismissAnimatedGameOverView:self.view.superview withCompletion:^(BOOL finished) {
        [self.view removeFromSuperview];
        if (self.squareGameOverViewDelegate)
            [self.squareGameOverViewDelegate restartGame];
    }];
}

- (IBAction)quitGame:(id)sender {
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
