//
//  NoteTabelModel.m
//  OnlyNote
//
//  Created by IMac on 16/3/17.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "NoteTabelModel.h"

@implementation NoteTabelModel

+(instancetype)configWithBmobObject:(BmobObject *)obj
{
    
    if (obj) {
        
        NoteTabelModel *model = [[NoteTabelModel alloc]init];
        model.objId = [obj objectForKey:@"objectId"];
        model.title = [obj objectForKey:@"title"];
        model.note_content = [obj objectForKey:@"note_content"];
        model.content_image = [obj objectForKey:@"content_image"];
        model.icon_image = [obj objectForKey:@"icon_image"];
        model.createdAt = [model getDateWithString:[obj objectForKey:@"createdAt"]];
        model.updatedAt = [model getDateWithString:[obj objectForKey:@"updatedAt"]];
        return model;
        
    }else{
        
        return nil;
    }
    
}

- (NSString *)getDateWithString:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:timeStr];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    
    return timeSp;
}

@end
