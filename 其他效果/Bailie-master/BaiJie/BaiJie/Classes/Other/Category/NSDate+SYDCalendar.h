//
//  NSDate+SYDCalendar.h
//  BaiJie
//
//  Created by ADMIN on 17/8/25.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SYDCalendar)
- (NSDateComponents *)deltaFrom:(NSDate *)from;
- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterDay;
@end
