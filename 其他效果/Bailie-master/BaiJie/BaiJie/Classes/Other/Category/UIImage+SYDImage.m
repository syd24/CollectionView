//
//  UIImage+SYDImage.m
//  BaiJie
//
//  Created by ADMIN on 17/6/28.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "UIImage+SYDImage.h"

@implementation UIImage (SYDImage)

+ (UIImage *)imageOriginalWithName:(NSString *)imageName{
    UIImage * image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (instancetype)circleImage{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [path addClip];
    [self drawAtPoint:CGPointZero];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)circleImageNamed:(NSString *)name{
    return [[self imageNamed:name] circleImage];
}



@end
