//
//  WZXDateToStr.h
//  WZXDateToStrDemo
//
//  Created by wordoor－z on 16/2/25.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZXDateToStrTool : NSObject
typedef NS_ENUM (NSInteger,StrType)
{
    //zh-CN:一秒、一分钟、一小时、一天、一周、一个月、一年前
    //en:A second, a minute, an hour, a day, a week, a month, a year ago
    StrType1,
    StrType2
};

+ (WZXDateToStrTool *)tool;

/**
 *  NSDate 转换
 *  NSDate conversion to Str
 */
- (NSString *)dateToStrWithDate:(NSDate *)date WithStrType:(StrType)type;


/**
 *  NSTimeInterval 转换
 *  NSTimeInterval conversion to Str
 */
- (NSString *)timeIntervalToStr:(NSTimeInterval )time WithStrType:(StrType)type;

/**
 *  字符串时间戳 转换
 *  Timestamp string conversion to Str
 */
- (NSString *)timeStrToStrWithTimeStr:(NSString *)timeStr WithStrType:(StrType)type;

@end
