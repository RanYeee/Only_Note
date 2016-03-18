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

        model.title = [obj objectForKey:@"title"];
        model.note_content = [obj objectForKey:@"note_content"];
        model.content_image = [obj objectForKey:@"content_image"];
        model.icon_image = [obj objectForKey:@"icon_image"];
        model.createdAt = [obj objectForKey:@"createdAt"];
        model.updatedAt = [obj objectForKey:@"updatedAt"];
        return model;
        
    }else{
        
        return nil;
    }
    
}

@end
