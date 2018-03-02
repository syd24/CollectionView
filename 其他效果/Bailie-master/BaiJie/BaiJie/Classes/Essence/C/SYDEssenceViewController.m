//
//  SYDEssenceViewController.m
//  BaiJie
//
//  Created by ADMIN on 17/6/28.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDEssenceViewController.h"
#import "SYDtitleButton.h"

#import "SYDAllTableViewController.h"
#import "SYDVideoTableViewController.h"
#import "SYDVoiceTableViewController.h"
#import "SYDPictureTableViewController.h"
#import "SYDWordTableViewController.h"
@interface SYDEssenceViewController ()<UIScrollViewDelegate>

@property(nonatomic,weak) UIView *titlesView;
@property (nonatomic,weak) SYDtitleButton * currentTitleButton;

@property (nonatomic , weak) UIView *titleUnderLine;

@property (nonatomic , weak) UIScrollView *scrollView;

@end

@implementation SYDEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    
    //初始化子控制器
    [self setupAllChildVcs];
    
    //设置scrollView
    [self setupScrollView];
    
    //设置titlesView
    [self setuptitlesView];
    
    //添加第0个子控制器到scr上
     [self addChildrenVCView:0];
}
//初始化子控制器
- (void)setupAllChildVcs{
    [self addChildViewController:[[SYDAllTableViewController alloc] init]];
    [self addChildViewController:[[SYDVideoTableViewController alloc] init]];
    [self addChildViewController:[[SYDVoiceTableViewController alloc] init]];
    [self addChildViewController:[[SYDPictureTableViewController alloc] init]];
    [self addChildViewController:[[SYDWordTableViewController alloc] init]];
}

//设置导航栏
- (void)setupNavBar{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}


//设置scrollView
- (void)setupScrollView{
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO;//点击状态栏的时候，这个scrollView不会滚动到最顶部
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    NSUInteger count = self.childViewControllers.count;
    scrollView.contentSize = CGSizeMake(count * scrollView.syd_width, 0);
    
}

//设置titlesView
- (void)setuptitlesView{
    UIView * titlesView = [[UIView alloc] init];
    //设置透明度
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.frame = CGRectMake(0, SYDNavigationTopH, ScreenW, SYDtitlesViewH);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //设置标题
    [self setupTitleButtons];
    
    //设置标题下划线
    [self setupTitleUnderLine];
}
 //设置标题
- (void)setupTitleButtons{
    //文字标题
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSUInteger count = titles.count;
    
    //标题按钮的尺寸
    CGFloat titleButtonW = self.titlesView.syd_width / count;
    CGFloat titleButtonH = self.titlesView.syd_height;
    
    for (NSUInteger i = 0; i < count; i ++) {
        SYDtitleButton *titleButton = [[SYDtitleButton alloc] init];
        [self.titlesView addSubview:titleButton];
        titleButton.tag = i;
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
//监听点击按钮
- (void)titleButtonClick:(SYDtitleButton *)titleButton{
    self.currentTitleButton.selected = NO;
    titleButton.selected = YES;
    self.currentTitleButton = titleButton;
    
    [UIView animateWithDuration:0.35 animations:^{

        self.titleUnderLine.syd_width = titleButton.titleLabel.syd_width + 10;
        self.titleUnderLine.syd_centerX = titleButton.syd_centerX;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.syd_width * titleButton.tag, 0);
        
    }completion:^(BOOL finished) {
        //添加子控制器到scr上
        [self addChildrenVCView:titleButton.tag];
    }];
    
    //设置scrtop
    for (NSUInteger i = 0; i < self.childViewControllers.count; i ++) {
        UIViewController * childrenVC = self.childViewControllers[i];
        if (!childrenVC.isViewLoaded) continue;
        UIScrollView * scrollView = (UIScrollView *)childrenVC.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        scrollView.scrollsToTop = (i == titleButton.tag);
        
    }
}

//设置标题下划线
- (void)setupTitleUnderLine{
    
    UIView * titleUnderLine = [[UIView alloc] init];
    titleUnderLine.syd_height = 2;
    titleUnderLine.syd_y = self.titlesView.syd_height - titleUnderLine.syd_height;
    titleUnderLine.backgroundColor = [UIColor redColor];
    [self.titlesView addSubview:titleUnderLine];
    self.titleUnderLine = titleUnderLine;
    
    SYDtitleButton * titleBtn = self.titlesView.subviews.firstObject;
    [titleBtn.titleLabel sizeToFit];
    
    titleBtn.selected = YES;
    self.currentTitleButton = titleBtn;
    self.titleUnderLine.syd_width = titleBtn.titleLabel.syd_width + 10;
    self.titleUnderLine.syd_centerX = titleBtn.syd_centerX;
    
}

//delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSUInteger index = scrollView.contentOffset.x / scrollView.syd_width;
    
    SYDtitleButton * titleBtn = self.titlesView.subviews[index];
    [self titleButtonClick:titleBtn];
    
}

//添加第几个的控制器的View（懒加载）
- (void)addChildrenVCView:( NSUInteger )index{
    
    
    UIView *childrenVCView = self.childViewControllers[index].view;
    
    //防止下面的代码执行多次
    if (childrenVCView.window) {
        return;
    }
    CGFloat scrollViewW = self.scrollView.syd_width;
    childrenVCView.frame = CGRectMake(scrollViewW * index, 0, scrollViewW, self.scrollView.syd_height);
    [self.scrollView addSubview:childrenVCView];
}

@end
