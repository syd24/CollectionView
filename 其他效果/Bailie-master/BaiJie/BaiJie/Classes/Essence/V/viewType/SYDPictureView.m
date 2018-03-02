 //
//  SYDPictureView.m
//  BaiJie
//
//  Created by ADMIN on 17/8/28.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDPictureView.h"
#import "SYDTopicModel.h"
#import "SYDSeeBigPictureViewController.h"
#import <DACircularProgress/DALabeledCircularProgressView.h>
#import <FLAnimatedImage/FLAnimatedImage.h>
#import "UIImageView+SYDImageView_DownLoad.h"
@interface SYDPictureView()

@property (nonatomic, weak)FLAnimatedImageView *bgImageView;

@property (nonatomic, weak)DALabeledCircularProgressView *progressView;

@end

@implementation SYDPictureView

{
    NSString * _url;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        FLAnimatedImageView *bgImageView = [[FLAnimatedImageView alloc] init];
        [self addSubview:bgImageView];
        self.bgImageView = bgImageView;
        
        DALabeledCircularProgressView *progressView = [[DALabeledCircularProgressView alloc] initWithFrame:CGRectZero];
        progressView.progressLabel.textColor = [UIColor blackColor];
        progressView.progressTintColor = SYDTableViewbackgroundColor;
        progressView.roundedCorners = YES;
        [self addSubview:progressView];
        self.progressView = progressView;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
   
}

- (void)setTopicModel:(SYDTopicModel *)topicModel{
    _topicModel = topicModel;
    
    
    self.bgImageView.frame = self.bounds;
    self.bgImageView.userInteractionEnabled = YES;
    [self.bgImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPic)]];
    
    CGFloat  centerX = topicModel.middleFrame.size.width / 2;
    CGFloat  centerY = topicModel.middleFrame.size.height / 2;
    self.progressView.center = CGPointMake(centerX, centerY);
    self.progressView.syd_width = 100;
    self.progressView.syd_height = 100;
    
    
    self.progressView.hidden = YES;
    self.progressView.progressLabel.text = @"";
    [self.progressView setProgress:topicModel.picProgress animated:NO];
    self.bgImageView.animatedImage = nil;
    self.bgImageView.image = nil;
    
    [self.bgImageView setOriginImage:topicModel.image1 thumbnailImage:topicModel.image0 placeholder:nil progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        self.progressView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        topicModel.picProgress = progress <= 0.01 ? 0.01 : progress;
         [self.progressView setProgress:topicModel.picProgress animated:YES];
        //这里有bug
        NSString * str = [NSString stringWithFormat:@"%.0f%%",topicModel.picProgress * 100];
        self.progressView.progressLabel.text = str;
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) {
            return ;
        }
        self.progressView.hidden = YES;
        if (topicModel.bigPicture) {
            CGFloat imageW = topicModel.middleFrame.size.width;
            CGFloat imageH = imageW * topicModel.height / topicModel.width;//大图等比例
            UIGraphicsBeginImageContextWithOptions(self.topicModel.middleFrame.size, 0, [UIScreen mainScreen].scale);
            [self.bgImageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.bgImageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        if ([topicModel.image1.pathExtension.lowercaseString isEqualToString:@"gif"]) {
            _url = topicModel.image1;
            [self gifForUrl:_url];
        }
        
    }];
    
    if (topicModel.isBigPicture) {
        self.bgImageView.contentMode = UIViewContentModeTop;
        self.bgImageView.clipsToBounds = YES;
        
    }else{
        self.bgImageView.contentMode = UIStackViewAlignmentFill;
        self.bgImageView.clipsToBounds = NO;
    }
    
}

//缓存策略

- (void)gifForUrl:(NSString *)url{
    id obj = [[self getCache] objectForKey:url];
    if (obj != nil) {
        
         NSLog(@"走了缓存");
        
        self.bgImageView.animatedImage = (FLAnimatedImage *)obj;
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        FLAnimatedImage *flimage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        
        [[self getCache] setObject:flimage forKey:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_url == url) {
                self.bgImageView.animatedImage = flimage;
            }else{
                
            }
        });
        
    });
}


- (NSCache *)getCache{
    static NSCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
        //能够缓存的对象的最大数量。默认值为0，表示没有限制
        cache.countLimit = GIFCacheCountLimit;
        NSLog(@"缓存了吗");
    });
    return cache;
}



- (void)seeBigPic{
    
    SYDSeeBigPictureViewController *vc = [[SYDSeeBigPictureViewController alloc] init];
    vc.topicModel = self.topicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    
}

@end
