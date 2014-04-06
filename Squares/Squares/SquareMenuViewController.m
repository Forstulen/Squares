//
//  SquareMenuViewController.m
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import "SquareMenuViewController.h"
#import "SquareGameViewController.h"

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)launchGameView:(id)sender {

    SquareGameViewController *gameController = [[SquareGameViewController alloc] initWithNibName:NSStringFromClass([SquareGameViewController class]) bundle:nil];

    [self presentViewController:gameController animated:NO completion:nil];
}

@end
