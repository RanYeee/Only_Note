//
//  LoginFieldView.m
//  OnlyNote
//
//  Created by RanyMac on 13/3/16.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "LoginFieldView.h"

@interface LoginFieldView ()

@property (nonatomic, strong) UIImageView *iconView;

@end
@implementation LoginFieldView

- (instancetype)initWithFrame:(CGRect)frame andLeftImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.frame = frame;
        
        self.iconImage = image;
        
        [self setupView];
                
    }
    
    return self;
}



- (void)setupView
{
    CGFloat iconWH = self.frame.size.height;
    
    UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(self.frame.origin.x + iconWH, self.frame.origin.y, self.frame.size.width - iconWH, self.frame.size.height)];
    
    textfield.textAlignment = NSTextAlignmentCenter;
    
    textfield.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    textfield.alpha = 0.45f;
    
    [self addSubview:textfield];
    
    
    self.iconView = [[UIImageView alloc]initWithImage:self.iconImage];
    
    self.iconView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, iconWH, iconWH);
    
    self.iconView.backgroundColor = [UIColor darkGrayColor];
    
    self.iconView.contentMode = UIViewContentModeCenter;
    
    [self addSubview:self.iconView];
    

    
}


@end
