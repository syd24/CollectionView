//
//  SYDRecommendCategoryModel.h
//  BaiJie
//
//  Created by ADMIN on 17/8/30.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYDRecommendCategoryModel : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *name;


@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger currentPage;


@end
