//
//  UserModel.h
//  OnlyNote
//
//  Created by rany on 19/3/16.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *bgImage_url;

@property (nonatomic, copy) NSString *iconImage_url;

@property (nonatomic, copy) NSString *userId;

+(instancetype)configWithBombUser:(BmobUser *)user;



@end
