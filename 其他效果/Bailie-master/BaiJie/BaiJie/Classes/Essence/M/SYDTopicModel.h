//
//  SYDTopicModel.h
//  BaiJie
//
//  Created by ADMIN on 17/8/23.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TopicType) {
    TopicTypeAll = 1,
    TopicTypePicture = 10,
    TopicTypeWord = 29,
    TopicTypeVoice = 31,
    TopicTypeVideo = 41
};


@interface SYDTopicModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, copy) NSString *text;//text
@property (nonatomic, copy) NSString * passtime;
@property (nonatomic, assign) NSInteger ding;
@property (nonatomic, assign) NSInteger cai;
@property (nonatomic, assign) NSInteger repost;
@property (nonatomic, assign) NSInteger comment;




@property (nonatomic, assign) NSInteger type;//中间图片类型

@property (nonatomic, assign) NSInteger width;//图片的width
@property (nonatomic, assign) NSInteger height;//图片的height
@property (nonatomic, copy) NSString *image0;//小图
@property (nonatomic, copy) NSString *image2;//中图
@property (nonatomic, copy) NSString *image1;//大图 




@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
@property (nonatomic, assign) CGFloat picProgress;


@property (nonatomic, assign) BOOL is_gif;
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

//计算cell高度
@property (nonatomic, assign,readonly) CGFloat cellHeight;
//中间内容frame
@property (nonatomic, assign,readonly) CGRect middleFrame;

@property (nonatomic,assign , readonly) CGFloat textHeight;



@end
