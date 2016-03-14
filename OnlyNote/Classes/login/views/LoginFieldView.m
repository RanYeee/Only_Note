//
//  LoginFieldView.m
//  OnlyNote
//
//  Created by RanyMac on 13/3/16.
//  Copyright © 2016年 IMac. All rights reserved.
//

NSString *const kHideKeyboardNotification = @"kHideKeyboardNotification";//隐藏键盘

#import "LoginFieldView.h"

@interface LoginFieldView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *iconView;

@end
@implementation LoginFieldView

- (instancetype)initWithFrame:(CGRect)frame andLeftImage:(UIImage *)image insertString:(EndEditingBlock)block
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.frame = frame;
        
        self.endEditingBlock = block;
        
        self.iconImage = image;
        
        [self setupView];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard) name:kHideKeyboardNotification object:nil];
                
    }
    
    return self;
}



- (void)setupView
{
    CGFloat iconWH = self.frame.size.height;
    
    CGRect fieldRect = CGRectMake(self.frame.origin.x + iconWH, self.frame.origin.y, self.frame.size.width - iconWH, self.frame.size.height);
    
    UIView *alphaView = [[UIView alloc]initWithFrame:fieldRect];
    
    alphaView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    alphaView.alpha = 0.55f;
    
    [self addSubview:alphaView];
    
    _textfield = [[UITextField alloc]initWithFrame:fieldRect];
    
    _textfield.textAlignment = NSTextAlignmentCenter;
    
    _textfield.backgroundColor = [UIColor clearColor];
    
    _textfield.borderStyle = UITextBorderStyleNone;
    
    _textfield.delegate = self;
    
    [self insertSubview:_textfield aboveSubview:alphaView];
    
    
    self.iconView = [[UIImageView alloc]initWithImage:self.iconImage];
    
    self.iconView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, iconWH, iconWH);
    
    self.iconView.backgroundColor = [UIColor darkGrayColor];
    
    self.iconView.contentMode = UIViewContentModeCenter;
    
    [self addSubview:self.iconView];
    

    

    
}

-(void)setPlaceHolder:(NSString *)placeHolder
{
    _textfield.placeholder = placeHolder;
}

- (void)hideKeyboard
{
    [self.textfield resignFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.endEditingBlock) {
        
        _endEditingBlock(textField.text);
    }
}

@end
