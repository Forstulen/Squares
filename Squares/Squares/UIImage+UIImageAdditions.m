//
//  UIImage+UIImageAdditions.m
//  Squares
//
//  Created by Romain on 4/6/14.
//
//

#import "UIImage+UIImageAdditions.h"
#import "NSDictionaryAdditions.h"

@implementation UIImage (UIImageAdditions)

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color {
    static NSMutableDictionary* imageDict = nil;
    
    if (imageDict == nil)
    {
        imageDict = [[NSMutableDictionary alloc] init];
    }
    
    if ([imageDict objectForKey:name] != nil) {
        NSMutableDictionary    *dict = [imageDict objectForKey:name];
        
        if ([dict objectForKey:color] != nil) {
            return [dict objectForKey:color];
        } else {
            UIImage *newImage = [UIImage createImage:name color:color];
            
            [dict setObject:newImage forKey:color];
            return newImage;
        }
    } else {
        NSMutableDictionary *dictColors = [[NSMutableDictionary alloc] init];
        UIImage *newImage = [UIImage createImage:name color:color];
        
        [dictColors setObject:newImage forKey:color];
        [imageDict setObject:dictColors forKey:name];
        
        return newImage;
    }
}

+ (UIImage *)createImage:(NSString *)name color:(UIColor *)color {
    UIImage *img = [UIImage imageNamed:name];
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, img.scale);
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    [img drawInRect:rect];
    CGContextSetFillColorWithColor(c, [color CGColor]);
    CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
    CGContextFillRect(c, rect);
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
