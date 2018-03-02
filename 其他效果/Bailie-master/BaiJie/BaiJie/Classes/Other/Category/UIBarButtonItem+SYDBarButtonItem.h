//
//  UIBarButtonItem+SYDBarButtonItem.h
//  BaiJie
//
//  Created by ADMIN on 17/7/5.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SYDBarButtonItem)
+ (UIBarButtonItem *)itemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title: (NSString *)title;

@end
