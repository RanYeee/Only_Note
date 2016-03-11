//
//  LoginTextfield.m
//  OnlyNote
//
//  Created by IMac on 16/3/11.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "LoginTextfield.h"


@implementation LoginTextfield

- (instancetype)initWithFrame:(CGRect)frame andLeftImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        
        imageView.frame = CGRectMake(0, 0, 10, 10);
        
        self.rightView = imageView;
        
        self.borderStyle = UITextBorderStyleNone;
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
