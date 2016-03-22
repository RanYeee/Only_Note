//
//  KLNotificationHelp.h
//  kinglianHealthUser
//
//  Created by IMac on 15/12/4.
//  Copyright © 2015年 Rany. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kLoginSuccessNotification;//登录成功



@interface KLNotificationHelp : NSObject

+ (void)postNotificationName:(NSString *)aName
                      object:(id)anObject;


+ (void)postNotification:(NSString*)notification
                userInfo:(NSDictionary*)userInfo
                  object:(id)object;


+ (void)addObserver:(id)observer
           selector:(SEL)aSelector
               name:(NSString *)aName
             object:(id)anObject;

+ (void)removeObserver:(id)observer
                  name:(NSString *)aName
                object:(id)anObject;

@end
