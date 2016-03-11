//
//  LoginViewController.m
//  OnlyNote
//
//  Created by IMac on 16/3/11.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTextfield.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    LoginTextfield *accountField = [[LoginTextfield alloc]initWithFrame:CGRectMake(100, 100, 100, 22) andLeftImage:[UIImage imageNamed:@"info.png"]];
    
    [self.view addSubview:accountField];
    
}


@end
