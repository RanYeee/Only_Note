//
//  EditToolBar.m
//  OnlyNote
//
//  Created by IMac on 16/3/22.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "EditToolBar.h"

static CGFloat kSpacing = 20.0f;

@implementation EditToolBar


-(instancetype)initWithFrame:(CGRect)frame andIconArray:(NSArray <NSString *>*)iconArr
{
    if (self = [super initWithFrame:frame]) {
        
        self.iconArray = iconArr;
        
        self.frame = frame;
        
        [self setupView];
        
    }
    
    return self;
}

-(instancetype)initWithIconArray:(NSArray <NSString *> *)iconArr
{
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, SCREEN_HEIGHT-44, SCREEN_WIDTH, 44);
        
        self.iconArray = iconArr;
        
        [self setupView];
        
    }
    
    return self;
}

- (void)setupView
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    CGFloat btnWH = self.frame.size.height;
    
    [self.iconArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UIButton *button = [[UIButton alloc]init];
        
        button.tag = idx;
        
        [button addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setImage:[UIImage imageNamed:obj] forState:UIControlStateNormal];
        
        button.frame = CGRectMake(idx*(btnWH+kSpacing)+10, 0, btnWH, btnWH);
        
        [self addSubview:button];
        
    }];
}

- (void)buttonTarget:(UIButton *)button
{
    
    if (self.delegate) {
        
        [self.delegate editToolBar:self didClickAtIndex:button.tag];
    }
    
}

@end
