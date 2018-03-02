//
//  SYDMeViewController.m
//  BaiJie
//
//  Created by ADMIN on 17/6/28.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDMeViewController.h"
#import "SYDMeTableViewCell.h"
@interface SYDMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *meTableView;

@end

@implementation SYDMeViewController

static NSString * const MeCellId = @"me";

-(UITableView *)meTableView{
    if (_meTableView == nil) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.frame = CGRectMake(0, 40, ScreenW, ScreenH);
        tableView.backgroundColor = SYDCommonBgColor;
        tableView.sectionHeaderHeight = 0;
        tableView.sectionFooterHeight = 10;
        tableView.contentInset = UIEdgeInsetsMake(- 25, 0, - 20, 0);
        tableView.tableFooterView = [[UIView alloc] init];
        [tableView registerClass:[SYDMeTableViewCell class] forCellReuseIdentifier:MeCellId];
        _meTableView = tableView;
        _meTableView.delegate = self;
        _meTableView.dataSource = self;
        
    }
    return _meTableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.meTableView];

    [self setupNav];
}


- (void)setupNav{
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(moonClick:)];
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingClick)];
    self.navigationItem.rightBarButtonItems = @[moonItem,settingItem];
}


- (void)moonClick:(UIButton *)btn{
    btn.selected = !btn.selected;
}
- (void)settingClick{
    
}

//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    SYDMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MeCellId];
    if (indexPat.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }else{
        cell.textLabel.text = @"离线下载";
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:false animated:true];
}

@end
