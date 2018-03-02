//
//  SYDSeeBigPictureViewController.m
//  BaiJie
//
//  Created by ADMIN on 17/8/28.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDSeeBigPictureViewController.h"
#import "SYDTopicModel.h"
@interface SYDSeeBigPictureViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation SYDSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    UIButton *dissMissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:dissMissBtn];
    dissMissBtn.frame = CGRectMake(10, 25, 40, 40);
    [dissMissBtn setImage:[UIImage imageNamed:@"showbig-left-icon"] forState:UIControlStateNormal];
    [dissMissBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    
    //UIImageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topicModel.image1] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    imageView.syd_width = scrollView.syd_width;
    imageView.syd_height = imageView.syd_width * self.topicModel.height / self.topicModel.width;
    imageView.syd_x = 0;
    if (imageView.syd_height > ScreenH) {
        imageView.syd_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.syd_height);
    }else{
        imageView.syd_centerY = scrollView.syd_height * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    //图片缩放
    CGFloat maxScale = self.topicModel.width / imageView.syd_width;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
    
}
- (void)disMiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

@end
