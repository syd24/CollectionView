//
//  SYDTabBarController.m
//  BaiJie
//
//  Created by ADMIN on 17/6/28.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDTabBarController.h"
#import "SYDEssenceViewController.h"
#import "SYDNewViewController.h"
#import "SYDPublishViewController.h"
#import "SYDFriendTrendViewController.h"
#import "SYDMeViewController.h"
#import "UIImage+SYDImage.h"
#import "SYDNavigationViewController.h"
@interface SYDTabBarController ()

@end

@implementation SYDTabBarController
//设置字体大小 颜色
+ (void)load{
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    NSMutableDictionary * attrsFont = [NSMutableDictionary dictionary];
    attrsFont[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsFont forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupAllChildViewController];
    [self setupAllTitleButton];
    
    //
    [self setupTabBar];
}

- (void)setupTabBar{
    SYDTabBar *tabBar = [[SYDTabBar alloc]init];
    [self setValue:tabBar forKey:@"tabBar"];
}


//添加所有子控制器
- (void)setupAllChildViewController{
    //精华
    SYDEssenceViewController * essenceVC = [[SYDEssenceViewController alloc] init];
    SYDNavigationViewController *nvc = [[SYDNavigationViewController alloc]initWithRootViewController:essenceVC];
    [self addChildViewController:nvc];
    
    //新帖
    SYDNewViewController * newVC = [[SYDNewViewController alloc] init];
    SYDNavigationViewController *nvc1 = [[SYDNavigationViewController alloc]initWithRootViewController:newVC];
    [self addChildViewController:nvc1];
    
    
    //关注
    SYDFriendTrendViewController * ftVC = [[SYDFriendTrendViewController alloc] init];
    SYDNavigationViewController *nvc3 = [[SYDNavigationViewController alloc]initWithRootViewController:ftVC];
    [self addChildViewController:nvc3];
    
    //wo
    SYDMeViewController * meVC = [[SYDMeViewController alloc] init];
    SYDNavigationViewController *nvc4 = [[SYDNavigationViewController alloc]initWithRootViewController:meVC];
    [self addChildViewController:nvc4];
    
}

//设置tabbar上的按钮内容
- (void)setupAllTitleButton{
    // 0:nav
    SYDNavigationViewController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    // 1:新帖
    SYDNavigationViewController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
    
    // 3.关注
    SYDNavigationViewController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    
    // 4.我
    SYDNavigationViewController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
}


@end
