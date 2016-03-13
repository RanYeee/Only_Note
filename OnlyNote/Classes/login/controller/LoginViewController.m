//
//  LoginViewController.m
//  OnlyNote
//
//  Created by IMac on 16/3/11.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginFieldView.h"
#import "UIImage+GIF.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.263 green:0.310 blue:0.365 alpha:1.000];
    
    [self setupView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}

- (void)setupView {
    
    UIImage  *image=[UIImage sd_animatedGIFNamed:@"snowGif"];
    
    UIImageView  *gifview=[[UIImageView alloc]initWithFrame:self.view.bounds];
    
    gifview.image=image;
    
    [self.view addSubview:gifview];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    
    titleLabel.text = @"Login";
    
    titleLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:30.0f];
    
    [self.view addSubview:titleLabel];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.view).offset(40);
        make.centerX.equalTo(self.view);
        
    }];
    
    
    LoginFieldView *accountField = [[LoginFieldView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/1.5, 40) andLeftImage:[UIImage imageNamed:@"tabbar_me"]];
    
    
    [self.view addSubview:accountField];
    
    [accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width/1.5, 40));
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-100);
        
    }];
    
    
    LoginFieldView *pwdField = [[LoginFieldView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/1.5, 40) andLeftImage:[UIImage imageNamed:@"icon_chatlock_white"]];
    
    [self.view addSubview:pwdField];
    
    [pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width/1.5, 40));
        make.centerX.equalTo(self.view);
        make.top.equalTo(accountField.mas_bottom).offset(20);
        
    }];
    
}





@end
