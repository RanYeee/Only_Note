//
//  AppMacro.h
//  OnlyNote
//
//  Created by IMac on 16/3/14.
//  Copyright © 2016年 IMac. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h


#endif /* AppMacro_h */


#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


//按比例获取高度
#define  WGiveHeight(HEIGHT) HEIGHT * [UIScreen mainScreen].bounds.size.height/568.0

//按比例获取宽度
#define  WGiveWidth(WIDTH) WIDTH * [UIScreen mainScreen].bounds.size.width/320.0

//按比例获取字体大小 以iphone5屏幕为基准
#define  WGiveFontSize(SIZE) SIZE * [UIScreen mainScreen].bounds.size.width/320.0


#define kUserBgImageCacheKey @"kUserBgImageCacheKey"  //用户背景缓存名

#define kUserIconImageCacheKey @"kUserIconImageCacheKey"  //用户头像缓存名