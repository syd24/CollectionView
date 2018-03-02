//
//  SYDFriendTrendViewController.m
//  BaiJie
//
//  Created by ADMIN on 17/6/28.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDFriendTrendViewController.h"
#import "SYDRecommentFriendsViewController.h"
#import "SYDLoginRegisterViewController.h"
@interface SYDFriendTrendViewController ()

@end

@implementation SYDFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    
    [self setupUI];
}

- (void)setupUI{
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(ScreenH/3);
        make.size.sizeOffset(CGSizeMake(60, 60));
        make.left.offset((ScreenW - 60)/2);
        
    }];
    headImageView.image = [UIImage imageNamed:@"header_cry_icon"];
    
    
    UILabel *reminderLabel = [[UILabel alloc] init];
    [self.view addSubview:reminderLabel];
    reminderLabel.numberOfLines = 0;
    reminderLabel.textAlignment = NSTextAlignmentCenter;
    reminderLabel.font = [UIFont systemFontOfSize:14];
    reminderLabel.text = @"快快登录吧, 关注百思最in牛人                                          好友动态让你过吧瘾儿~                          欧耶~~~~!";
    [reminderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(headImageView.mas_bottom).offset(5);
        make.left.offset(90);
        make.right.offset(-90);
        
    }];
    
    
    UIButton * loginregisterBtn = [[UIButton alloc] init];
    [self.view addSubview:loginregisterBtn];
    [loginregisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(reminderLabel.mas_bottom).offset(5);
        make.size.sizeOffset(CGSizeMake(140, 35));
        make.left.offset((ScreenW - 140)/2);
        
    }];
    [loginregisterBtn setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login"] forState:UIControlStateNormal];
    [loginregisterBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [loginregisterBtn setTitle:@"立即登录注册" forState:UIControlStateNormal];
    loginregisterBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [loginregisterBtn addTarget:self action:@selector(gologinregister) forControlEvents:UIControlEventTouchUpInside];
}

- (void)gologinregister{
    
    SYDLoginRegisterViewController *loginRegisterVC = [[SYDLoginRegisterViewController alloc] init];
    loginRegisterVC.block = ^{
        
    };
    [self presentViewController:loginRegisterVC animated:true completion:nil];
    
}

#pragma mark 跳转到推荐页面
- (void)friendsRecomment{
    SYDRecommentFriendsViewController * vc = [[SYDRecommentFriendsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

@end
