//
//  UIView+SYDFrame.m
//  BaiJie
//
//  Created by ADMIN on 17/7/5.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "UIView+SYDFrame.h"

@implementation UIView (SYDFrame)

- (void)setSyd_height:(CGFloat)syd_height{
    CGRect rect = self.frame;
    rect.size.height = syd_height;
    self.frame = rect;
}

- (CGFloat)syd_height{
    return self.frame.size.height;
}


- (void)setSyd_width:(CGFloat)syd_width{
    CGRect rect = self.frame;
    rect.size.width = syd_width;
    self.frame = rect;
}

- (CGFloat)syd_width{
    return self.frame.size.width;
}


- (void)setSyd_x:(CGFloat)syd_x{
    CGRect rect = self.frame;
    rect.origin.x = syd_x;
    self.frame = rect;
}

- (CGFloat)syd_x{
    return self.frame.origin.x;
}


- (void)setSyd_y:(CGFloat)syd_y{
    CGRect rect = self.frame;
    rect.origin.y = syd_y;
    self.frame = rect;
}

- (CGFloat)syd_y{
    return self.frame.origin.y;
}

- (void)setSyd_centerX:(CGFloat)syd_centerX{
    CGPoint center = self.center;
    center.x = syd_centerX;
    self.center = center;
}

- (CGFloat)syd_centerX{
   
    return self.center.x;
}


- (void)setSyd_centerY:(CGFloat)syd_centerY{
    CGPoint center = self.center;
    center.y = syd_centerY;
    self.center = center;
}

- (CGFloat)syd_centerY{
    return self.center.y;
}


@end
