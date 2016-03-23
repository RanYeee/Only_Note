//
//  BmobHelp.h
//  OnlyNote
//
//  Created by IMac on 16/3/18.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^UpdateSuccessBlock)(); //更新成功

typedef void(^UpdatetFailureBlock)(NSError *error); //更新失败

typedef void(^DeleteSuccessBlock)(); //删除成功

typedef void(^CreateTableSuccessBlock)(NSString *tableName); //创建表成功

@interface BmobHelp : NSObject


+(instancetype)shareInstance;

/**
 *  异步更新某列json数据
 *
 *  @param tableName 表名
 *  @param objId     行ID
 *  @param parameDic 数据字典
 *  @param success   请求成功回调
 *  @param failure   请求失败回调
 */

- (void)updateDataWithTableName:(NSString *)tableName
                           objectId:(NSString *)objId
                   parameDictionary:(NSDictionary *)parameDic
                            Success:(UpdateSuccessBlock)success
                            Failure:(UpdatetFailureBlock)failure;

/**
 *  保存数据到服务器
 *
 *  @param tableName 表名
 *  @param parameDic 数据字典
 *  @param success   存储成功
 *  @param failure   存储失败
 */
- (void)saveDataWithTableName:(NSString *)tableName
             parameDictionary:(NSDictionary *)parameDic
                      Success:(UpdateSuccessBlock)success
                      Failure:(UpdatetFailureBlock)failure;


/**
 *  创建记事本表
 *
 *  @param complete 完成回调表名
 */
-(void )createNoteTableComplete:(CreateTableSuccessBlock)complete;

@end
