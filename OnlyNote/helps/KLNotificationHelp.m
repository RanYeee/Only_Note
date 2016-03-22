//
//  KLNotificationHelp.m
//  kinglianHealthUser
//
//  Created by IMac on 15/12/4.
//  Copyright © 2015年 Rany. All rights reserved.
//

#import "KLNotificationHelp.h"

NSString *const kLoginSuccessNotification = @"kLoginSuccessNotification";//登录成功


@implementation KLNotificationHelp

+ (void)postNotificationName:(NSString *)aName object:(id)anObject
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
        
    });
}


+ (void)postNotification:(NSString *)notification
                userInfo:(NSDictionary *)userInfo
                  object:(id)object
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:notification object:object userInfo:userInfo];
    });
}

+ (void)addObserver:(id)observer
           selector:(SEL)aSelector
               name:(NSString *)aName
             object:(id)anObject
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:aName object:anObject];
    });
}

+(void)removeObserver:(id)observer
                 name:(NSString *)aName
               object:(id)anObject
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSNotificationCenter defaultCenter] removeObserver:observer name:aName object:anObject];
    });
    
}



@end
