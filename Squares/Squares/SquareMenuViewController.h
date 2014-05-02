//
//  SquareMenuViewController.h
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import <UIKit/UIKit.h>

@interface SquareMenuViewController : UIViewController {
    CADisplayLink   *_squareMenuLoop;
    CFTimeInterval  _squareElapsedTime;
    CFTimeInterval  _squareElapsedTimeDemo;
}


@property (weak, nonatomic) IBOutlet UIButton *squareMainModeButton;
@property (weak, nonatomic) IBOutlet UIButton *squareHardCoreButton;
@property (weak, nonatomic) IBOutlet UIButton *squareOptionsButton;
@property (weak, nonatomic) IBOutlet UIView *squarePopZone;


@property (weak, nonatomic) IBOutlet UIView *squarePopZone1;
@property (weak, nonatomic) IBOutlet UIView *squarePopZone2;

@property (weak, nonatomic) IBOutlet UILabel *squareCopyright;

@end
