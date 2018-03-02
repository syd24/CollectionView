//
//  SYDADViewController.m
//  BaiJie
//
//  Created by ADMIN on 17/6/28.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDADViewController.h"
#import <MJExtension/MJExtension.h>
#import <AFNetworking/AFNetworking.h>
#import "SYDADModel.h"
#import "UIImageView+WebCache.h"
#import "DALabeledCircularProgressView.h"
#import "SYDTabBarController.h"
#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface SYDADViewController ()

@property(nonatomic,strong) SYDADModel *itemModel;
@property(nonatomic,weak) UIImageView *adView;

@property(nonatomic,strong) UIButton *jumpBtn;
@property(nonatomic,strong) DALabeledCircularProgressView *progressV;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation SYDADViewController

- (UIImageView *)adView{
    if (_adView == nil) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.view addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        _adView = imageView;
    }
    return _adView;
}

//跳转到广告页
- (void)tap{
    NSURL * url = [NSURL URLWithString:_itemModel.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.adView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    self.adView.contentMode = UIViewContentModeScaleToFill;
    [self loadADData];
    [self setupProgressAndjumpBtn];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

- (void)timeChange{
    static int i = 30;
    self.progressV.hidden = NO;
    
    CGFloat progress = 1.0 * (30.0 - i + 1) / 30.0;
    [self.progressV setProgress:progress animated:YES];
    
    if (i == 0) {
        self.progressV.hidden = YES;
        [self clickJump:nil];
    }
    i--;
}

- (void)setupProgressAndjumpBtn{
   
    
    self.progressV = [[DALabeledCircularProgressView alloc]init];
    self.progressV.frame = CGRectMake(ScreenW - 80, 60, 60, 60);
    [self.view addSubview:self.progressV];
    self.progressV.roundedCorners = YES;
    self.progressV.progressLabel.textColor = [UIColor redColor];
    self.progressV.trackTintColor = [UIColor redColor];
    self.progressV.progressTintColor =  [UIColor blueColor];
    self.progressV.hidden = YES;
    self.progressV.progressLabel.text = @"";
    self.progressV.thicknessRatio = 0.1;
    [self.progressV setProgress:0 animated:NO];
    
    UIButton *jumpBtn = [[UIButton alloc]init];
    [self.progressV addSubview:jumpBtn];
    jumpBtn.layer.cornerRadius = 55/2;
    jumpBtn.clipsToBounds = YES;
    jumpBtn.frame = CGRectMake(2.5, 2.5, 55, 55);
    [jumpBtn addTarget:self action:@selector(clickJump:) forControlEvents:UIControlEventTouchUpInside];
    [jumpBtn setBackgroundColor:[UIColor darkGrayColor]];
    [jumpBtn setTitle:@"跳转" forState:UIControlStateNormal];
    self.jumpBtn = jumpBtn;

    
}


- (void)clickJump:(id)sender{
     [UIApplication sharedApplication].keyWindow.rootViewController = [[SYDTabBarController alloc] init];
    [_timer invalidate];
}

//加载数据
- (void)loadADData{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableSet *newSet = [NSMutableSet set];
    newSet.set = mgr.responseSerializer.acceptableContentTypes;
    [newSet addObject:@"text/html"];
    mgr.responseSerializer.acceptableContentTypes = newSet;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        _itemModel = [SYDADModel mj_objectWithKeyValues:adDict];
        CGFloat h = ScreenW / _itemModel.w;
        if (h > 0) {
        
            [self.adView sd_setImageWithURL:[NSURL URLWithString:_itemModel.w_picurl]];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

@end
