//
//  TitleTextfield.m
//  OnlyNote
//
//  Created by IMac on 16/3/22.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "TitleTextfield.h"

@implementation TitleTextfield

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.borderStyle = UITextBorderStyleNone;
        
        self.textColor = [UIColor darkGrayColor];
        
        self.font = [UIFont fontWithName:@"ProximaNova-Light" size:WGiveFontSize(25)];
    
        
        
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    // 设置富文本属性
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.font;
    dictM[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    CGPoint point = CGPointMake(10, (rect.size.height - self.font.lineHeight) * 0.5);
    
    [self.placeholder drawAtPoint:point withAttributes:dictM];
    
}

@end
