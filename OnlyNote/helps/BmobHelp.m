//
//  BmobHelp.m
//  OnlyNote
//
//  Created by IMac on 16/3/18.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "BmobHelp.h"

@implementation BmobHelp

+(instancetype)shareInstance
{
    static BmobHelp *bmobhelp = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        bmobhelp = [[BmobHelp alloc]init];
    });
    
    return bmobhelp;
    
}

- (void)updateDataWithTableName:(NSString *)tableName
                           objectId:(NSString *)objId
                      parameDictionary:(NSDictionary *)parameDic
                               Success:(UpdateSuccessBlock)success
                               Failure:(UpdatetFailureBlock)failure
{
   
    BmobObjectsBatch *batch = [[BmobObjectsBatch alloc] init] ;
    
    [batch updateBmobObjectWithClassName:tableName objectId:objId parameters:parameDic];
    
    [batch batchObjectsInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if (isSuccessful) {
            
            success();
            
        }else{
            
            failure(error);
        }
        
    }];
    
}

- (void)saveDataWithTableName:(NSString *)tableName
                   parameDictionary:(NSDictionary *)parameDic
                            Success:(UpdateSuccessBlock)success
                            Failure:(UpdatetFailureBlock)failure
{
    BmobObjectsBatch    *batch = [[BmobObjectsBatch alloc] init] ;
    //在GameScore表中创建一条数据
    [batch saveBmobObjectWithClassName:tableName parameters:parameDic];
    
    [batch batchObjectsInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if (isSuccessful) {
            
            success();
            
        }else{
            
            failure(error);
        }
        
    }];
}



@end
