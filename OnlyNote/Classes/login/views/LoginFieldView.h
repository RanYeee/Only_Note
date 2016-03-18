//
//  LoginFieldView.h
//  OnlyNote
//
//  Created by RanyMac on 13/3/16.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kHideKeyboardNotification;

typedef void(^EndEditingBlock)(NSString *insertString);

@interface LoginFieldView : UIView

{
    EndEditingBlock _endEditingBlock;
}

@property (nonatomic, strong) UIImage *iconImage;

@property (nonatomic ,strong) NSString *placeHolder;

@property (nonatomic ,strong) UITextField *textfield;


- (instancetype)initWithFrame:(CGRect)frame andLeftImage:(UIImage *)image insertString:(EndEditingBlock)block;

@end
