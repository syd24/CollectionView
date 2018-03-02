//
//  SYDTopicModel.m
//  BaiJie
//
//  Created by ADMIN on 17/8/23.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDTopicModel.h"

@implementation SYDTopicModel
{
    CGFloat _cellHeight;
    CGFloat _textHeight;
    CGRect _middleFrame;
}

-(CGFloat)cellHeight{
    
    if (_cellHeight) return _cellHeight;
    
    _cellHeight += 70;
    CGSize textMaxSize = CGSizeMake(ScreenW - 2 * Margin, MAXFLOAT);
    //文字高度
    _textHeight = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    _cellHeight += _textHeight + Margin;
    
    //计算中间图片 声音 视频高度
    if (self.type != TopicTypeWord) {
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * self.height / self.width;
        if (middleH > ScreenH) {
            middleH = 300;
            _bigPicture = YES;
        }
        
        CGFloat middleY = _cellHeight;
        CGFloat middleX = Margin;
        _middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellHeight += middleH + Margin;
        
    }
    
    _cellHeight += 35;
    
    return _cellHeight;
}

- (NSString *)passtime{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [fmt dateFromString:_passtime];
    
    if (create.isThisYear) {//今年
        if (create.isToday) {
            
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            if (cmps.hour > 1) {
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            } else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
            
            
        }else if (create.isYesterDay){
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
            
        }else{
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        
    }else{
        return  _passtime;
    }
}

@end
