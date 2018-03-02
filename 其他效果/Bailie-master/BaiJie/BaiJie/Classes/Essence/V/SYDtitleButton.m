//
//  SYDtitleButton.m
//  BaiJie
//
//  Created by ADMIN on 17/8/1.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDtitleButton.h"

@implementation SYDtitleButton

//构造方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}


- (void)setHighlighted:(BOOL)highlighted{
}

@end
