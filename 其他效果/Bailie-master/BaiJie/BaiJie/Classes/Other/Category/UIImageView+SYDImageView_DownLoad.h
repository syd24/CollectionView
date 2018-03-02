//
//  UIImageView+SYDImageView_DownLoad.h
//  BaiJie
//
//  Created by ADMIN on 17/8/24.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface UIImageView (SYDImageView_DownLoad)

- (void)setHeader:(NSString * _Nonnull )headerurl;

- (void)setOriginImage:(NSString *_Nullable)originImageURL thumbnailImage:(NSString *_Nullable)thumbnailImageURL placeholder:(UIImage *_Nullable)placeholder progress:(nullable SDWebImageDownloaderProgressBlock )progressBlock completed:(SDExternalCompletionBlock _Nullable)completedBlock;

@end
