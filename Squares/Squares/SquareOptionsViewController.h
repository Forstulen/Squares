//
//  SquareOptionsViewController.h
//  Squares
//
//  Created by Romain on 4/25/14.
//
//

#import <UIKit/UIKit.h>

@interface SquareOptionsViewController : UIViewController {
    CADisplayLink   *_squareMenuLoop;
    CFTimeInterval  _squareElapsedTime;
}

@property (weak, nonatomic) IBOutlet UILabel *squareSoundsLabel;
@property (weak, nonatomic) IBOutlet UISlider *squareSoundSlider;
@property (weak, nonatomic) IBOutlet UILabel *squareMusicLabel;
@property (weak, nonatomic) IBOutlet UISlider *squareMusicSlider;
@property (weak, nonatomic) IBOutlet UIView *squareLinesZone;

@property (weak, nonatomic) IBOutlet UIButton *squareDoneButton;
@end
