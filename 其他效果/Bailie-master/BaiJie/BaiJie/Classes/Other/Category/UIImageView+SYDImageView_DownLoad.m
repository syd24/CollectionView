//
//  UIImageView+SYDImageView_DownLoad.m
//  BaiJie
//
//  Created by ADMIN on 17/8/24.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "UIImageView+SYDImageView_DownLoad.h"
#import "UIImage+SYDImage.m"
@implementation UIImageView (SYDImageView_DownLoad)

- (void)setHeader:(NSString *)headerurl{
    
    UIImage *placeholder = [UIImage circleImageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:headerurl] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        self.image =  [image circleImage];
    }];

    
}

- (void)setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock completed:(SDExternalCompletionBlock)completedBlock{
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageURL];
    if (originImage) {
        //直接显示大图
        //[self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder options:0 progress:progressBlock completed:completedBlock];
        
        self.image = originImage;
        completedBlock(originImage, nil, 0, [NSURL URLWithString:originImageURL]);
        
    }else{
        if (mgr.isReachableViaWiFi) {
            [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder options:0 progress:progressBlock completed:completedBlock];
        }else if (mgr.isReachableViaWWAN){
            //可以从沙河取
            BOOL  downloadOriginImageWhen3GOr4G = YES;
            if (downloadOriginImageWhen3GOr4G) {
                 [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder options:0 progress:progressBlock completed:completedBlock];
            }else{
                 [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder options:0 progress:progressBlock completed:completedBlock];
            }
            
        }else{
            
            UIImage *thumbnaiImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if (thumbnaiImage) {
                self.image = thumbnaiImage;
                completedBlock(thumbnaiImage, nil, 0, [NSURL URLWithString:thumbnailImageURL]);
            }else{
                self.image = placeholder;
            }
            
        }
        
    }
    
}


@end
