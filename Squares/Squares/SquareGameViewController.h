//
//  SquareGameViewController.h
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import <UIKit/UIKit.h>

@class SquareGrid;

@interface SquareGameViewController : UIViewController {
    SquareGrid      *_squareGrid;
    CFTimeInterval  _squareSavedTime;
}

- (void)addSquare;
- (void)removeSquare:(CGPoint)point;
- (void)checkCollisions;

@property (weak, nonatomic) IBOutlet UIView *GameBoard;

@end
