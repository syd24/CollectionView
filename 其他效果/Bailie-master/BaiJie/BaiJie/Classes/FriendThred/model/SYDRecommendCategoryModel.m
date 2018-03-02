//
//  SYDRecommendCategoryModel.m
//  BaiJie
//
//  Created by ADMIN on 17/8/30.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDRecommendCategoryModel.h"

@implementation SYDRecommendCategoryModel

- (NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}


@end
