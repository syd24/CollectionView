//
//  SYDLoginRegisterViewController.m
//  BaiJie
//
//  Created by ADMIN on 17/8/31.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDLoginRegisterViewController.h"

@interface SYDLoginRegisterViewController ()

@end

@implementation SYDLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [self.view addSubview:bgImageView];
    bgImageView.userInteractionEnabled = YES;
    bgImageView.frame = self.view.bounds;
    bgImageView.image = [UIImage imageNamed:@"login_register_background"];
    
    UIButton * dismissBtn = [[UIButton alloc] init];
    [self.view addSubview:dismissBtn];
    dismissBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    dismissBtn.frame = CGRectMake(30, 30, 40, 40);
    [dismissBtn setImage:[UIImage imageNamed:@"login_close_icon"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)dismissClick{
    [self dismissViewControllerAnimated:true completion:nil];
    self.block();
}

@end
