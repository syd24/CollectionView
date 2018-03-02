//
//  UIImage+SYDImage.h
//  BaiJie
//
//  Created by ADMIN on 17/6/28.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SYDImage)
+ (UIImage *)imageOriginalWithName:(NSString *)imageName;

+ (instancetype)circleImageNamed:(NSString *)name;
- (instancetype)circleImage;
@end
