//
//  SYDTabBar.m
//  BaiJie
//
//  Created by ADMIN on 17/7/5.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDTabBar.h"
#import "UIView+SYDFrame.h"

@interface SYDTabBar ()

@property (nonatomic, weak) UIButton * plusButton;

@property (nonatomic, weak) UIControl * currentButtton;

@end

@implementation SYDTabBar

- (UIButton *)plusButton{
    if (_plusButton == nil) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [self addSubview:btn];
        _plusButton = btn;
    }
    return  _plusButton;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger count = self.items.count;
    CGFloat btnW = self.syd_width / (count + 1);
    CGFloat btnH = self.syd_height;
    CGFloat x = 0;
    int i = 0;
    //设置内部子控件的坐标
    for (UIControl *tabBarButton in self.subviews) {
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i == 0 && self.currentButtton == nil ) {
                self.currentButtton = tabBarButton;
            }
            
            if (i == 2) {
                i += 1;
            }
            x = i * btnW;
            tabBarButton.frame = CGRectMake(x, 0, btnW, btnH);
            i ++;
            
            [tabBarButton addTarget:self action:@selector(tabBarClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    //设置发布按钮位置
    self.plusButton.center = CGPointMake(self.syd_width / 2, self.syd_height /2);
    
    
}

- (void)tabBarClick:(UIControl *)tabbarBtn{
    if (self.currentButtton == tabbarBtn) {
        
    }
    self.currentButtton = tabbarBtn;
}


@end
