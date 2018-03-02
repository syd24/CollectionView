//
//  SYDVoiceView.m
//  BaiJie
//
//  Created by ADMIN on 17/8/28.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDVoiceView.h"
#import "SYDTopicModel.h"
@interface SYDVoiceView ()

@property (nonatomic, weak)UIImageView *bgImageView;


@end


@implementation SYDVoiceView

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
    
    self.bgImageView.backgroundColor = [UIColor redColor];
    self.bgImageView.frame = self.bounds;
}

- (void)setTopicModel:(SYDTopicModel *)topicModel{
    _topicModel = topicModel;
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image1]];
}

@end
