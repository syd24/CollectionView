//
//  SYDNetworkTools.m
//  BaiJie
//
//  Created by ADMIN on 17/7/31.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDNetworkTools.h"


@protocol HTTPProxy <NSObject>
@optional
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end

@interface SYDNetworkTools ()<HTTPProxy>

@end

@implementation SYDNetworkTools

+ (instancetype)sharedTools{
    static SYDNetworkTools * tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[self alloc] init];
        
        tools.responseSerializer.acceptableContentTypes = [tools.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        tools.responseSerializer.acceptableContentTypes = [tools.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        
    });
    return tools;
}

- (void)netrequest:(HTTPMethod)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void (^)(id, NSError *))finished{
    
    [[SYDNetworkTools sharedTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    void(^successCallBack)(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject){
        
        finished(responseObject,nil);
        
    };
    
    void (^failureCallBack)(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        finished(nil,error);
        
    };
    
    NSString *methodName = (method == GET) ? @"GET" : @"POST";
    
    //resume  恢复
    [[self dataTaskWithHTTPMethod:methodName URLString:urlString parameters:parameters uploadProgress:nil downloadProgress:nil success:successCallBack failure:failureCallBack] resume];
    
}

- (void)request:(HTTPMethod)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void(^)(id,NSError *))finished{
    
    [[SYDNetworkTools sharedTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    void(^successCallback)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
         finished(responseObject,nil);
    };
    
    void(^failureCallBack)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finished(nil,error);
    };

    if (method == GET) {
        [self GET:urlString parameters:parameters progress:nil success:successCallback failure:failureCallBack];
    }else{
        [self POST:urlString parameters:parameters progress:nil success:successCallback failure:failureCallBack];
    }
    
    
}


@end
