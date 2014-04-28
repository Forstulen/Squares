//
//  UIImage+UIImageAdditions.h
//  Squares
//
//  Created by Romain on 4/6/14.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageAdditions)

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color;
+ (UIImage *)createImage:(NSString *)name color:(UIColor *)color;

@end
