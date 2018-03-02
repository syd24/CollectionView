//
//  SYDNetworkTools.h
//  BaiJie
//
//  Created by ADMIN on 17/7/31.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


//类型别名
typedef enum : NSUInteger{
    GET,
    POST,
} HTTPMethod;

@interface SYDNetworkTools : AFHTTPSessionManager

+ (instancetype)sharedTools;

- (void)request:(HTTPMethod)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void(^)(id,NSError *))finished;

- (void)netrequest:(HTTPMethod)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void (^)(id, NSError *))finished;

@end
