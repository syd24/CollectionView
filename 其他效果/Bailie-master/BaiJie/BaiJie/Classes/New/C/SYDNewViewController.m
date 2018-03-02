//
//  SYDNewViewController.m
//  BaiJie
//
//  Created by ADMIN on 17/6/28.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDNewViewController.h"
#import "UIBarButtonItem+SYDBarButtonItem.h"
#import "SYDSubTagsViewController.h"
@interface SYDNewViewController ()

@end

@implementation SYDNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
}

// 设置导航栏图标
- (void)setupNavigation{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] selImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(showHotPeople)];
    
     self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)showHotPeople{
    SYDSubTagsViewController * subTagsVc = [[SYDSubTagsViewController alloc] init];
    [self.navigationController pushViewController:subTagsVc animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
