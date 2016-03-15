//
//  ImageCropViewController.h
//  OnlyNote
//
//  Created by IMac on 16/3/15.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageCropDelegate <NSObject>

@optional

//确定(自动将裁剪的图片存入相册)
-(void)confirmClickWithImage:(UIImage *)image;

//返回
-(void)backClick;


@end

@interface ImageCropViewController : UIViewController

@property (nonatomic,weak) id <ImageCropDelegate> delegate;

//初始化
-(instancetype)initWithImage:(UIImage *)image;

@end
