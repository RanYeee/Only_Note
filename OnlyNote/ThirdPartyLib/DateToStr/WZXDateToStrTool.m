//
//  WZXDateToStr.m
//  WZXDateToStrDemo
//
//  Created by wordoor－z on 16/2/25.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WZXDateToStrTool.h"

@implementation WZXDateToStrTool

+ (WZXDateToStrTool *)tool
{
    static WZXDateToStrTool * tool = nil;
    if (tool == nil)
    {
        tool = [[WZXDateToStrTool alloc]init];
    }
    return tool;
}

- (NSString *)dateToStrWithDate:(NSDate *)date WithStrType:(StrType)type
{
    NSTimeInterval time = [date timeIntervalSince1970];
    
    return [self timeIntervalToStr:time WithStrType:type];
}

- (NSString *)timeStrToStrWithTimeStr:(NSString *)timeStr WithStrType:(StrType)type
{
    NSTimeInterval time = [timeStr longLongValue];
    
    return [self timeIntervalToStr:time WithStrType:type];
}

- (NSString *)timeIntervalToStr:(NSTimeInterval)time WithStrType:(StrType)type
{
    NSString * langCode = [self getCurrentLanguage];
    
    NSArray * titleArr = @[
                           @{
                               @"second":@"秒前",
                               @"minute":@"分钟前",
                               @"hour"  :@"小时前",
                               @"day"   :@"天前",
                               @"month" :@"月前",
                               @"year"  :@"年前",
                               @"now"   :@"刚刚"
                               },
                           @{
                               @"second":@" seconds ago",
                               @"minute":@" minute ago",
                               @"hour"  :@" hour ago",
                               @"day"   :@" day ago",
                               @"month" :@" month ago",
                               @"year"  :@" year ago",
                               @"now"   :@"just now"
                               }
                           ];
    
    NSDictionary * titleDic ;
    if ([langCode isEqualToString:@"zh"])
    {
        titleDic = titleArr[0];
    }
    else
    {
        titleDic = titleArr[1];
    }
    
    //获取本地时间
    NSDate * nowDate = [NSDate date];
    
    NSTimeInterval nowtime = [nowDate timeIntervalSince1970];
    
    //时间差
    NSTimeInterval gapTime = nowtime - time;
    
    int hour = gapTime/(60 * 60);
    
    int minute = (gapTime - hour*60*60)/60;
    
    int second = (gapTime - hour*60*60 - minute*60);
//    NSLog(@"%d %d %d",hour,minute,second);
    switch (type)
    {
        case StrType1:
        {
            if (hour < 1)
            {
                if (0< minute && minute < 1)
                {
                    return [NSString stringWithFormat:@"%d%@",second,titleDic[@"second"]];
                }
                else if (minute > 1)
                {
                    return [NSString stringWithFormat:@"%d%@",minute,titleDic[@"minute"]];
                }
                else
                {
                    return [NSString stringWithFormat:@"%@",titleDic[@"now"]];
                }
            }
            else if (hour > 1 && hour < 24)
            {
                return [NSString stringWithFormat:@"%d%@",hour,titleDic[@"hour"]];
            }
            else if(hour > 24  && hour < 24 * 30)
            {
                return [NSString stringWithFormat:@"%d%@",hour/24,titleDic[@"day"]];
            }
            else if(hour > 24 * 30 && hour < 24 * 365)
            {
                return [NSString stringWithFormat:@"%d%@",hour/(24*30),titleDic[@"month"]];
            }
            else if(hour > 24 * 365)
            {
                return [NSString stringWithFormat:@"%d%@",hour/(24*365),titleDic[@"year"]];
            }
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

//获取系统语言
- (NSString *)getCurrentLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    if ([[languages objectAtIndex:0] containsString:@"en"]) {
        return @"en";
    }
    else if([[languages objectAtIndex:0] containsString:@"zh"])
    {
        return @"zh";
    }
    else
    {
        return nil;
    }
}
@end
