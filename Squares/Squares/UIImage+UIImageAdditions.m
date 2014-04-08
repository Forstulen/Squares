//
//  UIImage+UIImageAdditions.m
//  Squares
//
//  Created by Romain on 4/6/14.
//
//

#import "UIImage+UIImageAdditions.h"

@implementation UIImage (UIImageAdditions)

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color {
    UIImage *img = [UIImage imageNamed:name];
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);

    UIGraphicsBeginImageContextWithOptions(rect.size, NO, img.scale);
    CGContextRef c = UIGraphicsGetCurrentContext();

    [img drawInRect:rect];
    CGContextSetFillColorWithColor(c, [color CGColor]);
    CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
    CGContextFillRect(c, rect);

    return UIGraphicsGetImageFromCurrentImageContext();
}

@end
