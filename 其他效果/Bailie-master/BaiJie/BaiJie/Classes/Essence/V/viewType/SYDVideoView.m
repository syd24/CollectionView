//
//  SYDVideoView.m
//  BaiJie
//
//  Created by ADMIN on 17/8/28.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDVideoView.h"
#include "SYDTopicModel.h"
@interface SYDVideoView ()

@property (nonatomic, weak)UIImageView *bgImageView;


@end


@implementation SYDVideoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *bgImageView = [[UIImageView alloc] init];
        [self addSubview:bgImageView];
        self.bgImageView = bgImageView;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.bgImageView.frame = self.bounds;
}

- (void)setTopicModel:(SYDTopicModel *)topicModel{
    _topicModel = topicModel;
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image1]];
}


@end
