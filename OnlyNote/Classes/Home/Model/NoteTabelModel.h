//
//  NoteTabelModel.h
//  OnlyNote
//
//  Created by IMac on 16/3/17.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteTabelModel : NSObject

@property (nonatomic ,copy) NSString *objId;

@property (nonatomic ,copy) NSString *title;

@property (nonatomic ,copy) NSString *note_content;

@property (nonatomic ,copy) NSString *content_image;

@property (nonatomic ,copy) NSString *icon_image;

@property (nonatomic ,copy) NSString *createdAt;

@property (nonatomic ,copy) NSString *updatedAt;


+(instancetype)configWithBmobObject:(BmobObject *)obj;

@end
