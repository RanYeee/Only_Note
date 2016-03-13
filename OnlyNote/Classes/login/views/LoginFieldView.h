//
//  LoginFieldView.h
//  OnlyNote
//
//  Created by RanyMac on 13/3/16.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginFieldView : UIView
@property (nonatomic, strong) UIImage *iconImage;

- (instancetype)initWithFrame:(CGRect)frame andLeftImage:(UIImage *)image;
@end
