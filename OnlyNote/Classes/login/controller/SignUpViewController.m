//
//  SignUpViewController.m
//  OnlyNote
//
//  Created by IMac on 16/3/14.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "SignUpViewController.h"
#import "LoginTextfield.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.85620777027027];
    
    LoginTextfield *userField = [[LoginTextfield alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/1.5, 40)];
    
    userField.placeholder = @"Username";
    
    [self.view addSubview:userField];
    
    [userField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/1.5, 40));
    }];

}



@end
