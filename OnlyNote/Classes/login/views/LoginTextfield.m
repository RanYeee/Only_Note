//
//  LoginTextfield.m
//  OnlyNote
//
//  Created by IMac on 16/3/11.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "LoginTextfield.h"


@implementation LoginTextfield

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.borderStyle = UITextBorderStyleNone;
        
        self.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
}

//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect
{
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    [[UIColor groupTableViewBackgroundColor] setFill];
//    
//    [self.placeholder drawInRect:<#(CGRect)#> withAttributes:<#(nullable NSDictionary<NSString *,id> *)#>];
}


- (NSAttributedString *)attributedStringWithString:(NSString *)string color:(UIColor *)color font:(UIFont *)font {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = color;
    attrs[NSFontAttributeName] = font;
    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:string attributes:attrs];
    return attributedStr;
}

@end
