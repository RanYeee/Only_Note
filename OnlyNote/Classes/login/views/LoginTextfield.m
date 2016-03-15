//
//  LoginTextfield.m
//  OnlyNote
//
//  Created by IMac on 16/3/11.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "LoginTextfield.h"

NSString *const kResignFirstResponderNotification = @"kResignFirstResponderNotification";

@implementation LoginTextfield

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.borderStyle = UITextBorderStyleNone;
        
        self.textColor = [UIColor whiteColor];
        
        self.font = [UIFont fontWithName:@"ProximaNova-Light" size:17];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard) name:kResignFirstResponderNotification object:nil];
        
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    // 设置富文本属性
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.font;
    dictM[NSForegroundColorAttributeName] = [UIColor groupTableViewBackgroundColor];
    CGPoint point = CGPointMake(10, (rect.size.height - self.font.lineHeight) * 0.5);
    
    [self.placeholder drawAtPoint:point withAttributes:dictM];
    
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    //return CGRectInset( bounds, 10 , 0 );
    
    CGRect inset = CGRectMake(bounds.origin.x +15, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    
    return inset;
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    //return CGRectInset(bounds, 50, 0);
    
    

    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-10, bounds.size.height);

    
    return inset;
    
}

- (void)hideKeyboard
{
    [self resignFirstResponder];
}

@end
