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
#import "DeformationButton.h"
#import "SignUpViewController.h"
#import "RNNavigationController.h"
#import "UserModel.h"
#import "SDWebImageManager.h"
#import "MainTabbarController.h"
#import "HomeViewController.h"
#import "BmobHelp.h"

@interface LoginViewController ()<UITextFieldDelegate>

{
    NSString *_pwd;
    
    NSString *_userName;
}

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
    
    UIImage  *image=[UIImage imageNamed:@"bgImage.jpg"];
    
    UIImageView  *gifview=[[UIImageView alloc]initWithFrame:self.view.bounds];
    
    gifview.userInteractionEnabled = YES;
    
    gifview.image=image;
    
    [self.view addSubview:gifview];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    
    [gifview addGestureRecognizer:tapGesture];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    
    titleLabel.text = @"Login";
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:30.0f];
    
    [self.view addSubview:titleLabel];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.view).offset(40);
        make.centerX.equalTo(self.view);
        
    }];
    
    CGRect fieldRect = CGRectMake(0, 0, self.view.frame.size.width/1.5, 40);
    
    LoginFieldView *accountField = [[LoginFieldView alloc]initWithFrame: fieldRect andLeftImage:[UIImage imageNamed:@"icon_viewer"] insertString:^(NSString *insertString) {
        
        
        _userName = insertString;
        
    }];
    
    accountField.placeHolder = @"Username";
    
    [self.view addSubview:accountField];
    
    [accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width/1.5, 40));
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-100);
        
    }];
    
    
    LoginFieldView *pwdField = [[LoginFieldView alloc]initWithFrame:fieldRect andLeftImage:[UIImage imageNamed:@"icon_chatlock_white"] insertString:^(NSString *insertString) {
        
            NSLog(@">>>>>>%@",insertString);
        
        _pwd = insertString;
        
    }];
    
    pwdField.placeHolder = @"Password";
    
    [self.view addSubview:pwdField];
    
    [pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width/1.5, 40));
        make.centerX.equalTo(self.view);
        make.top.equalTo(accountField.mas_bottom).offset(20);
        
    }];
/*
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *closeImage = [UIImage imageNamed:@"barbuttonicon_back"];
    
    [closeBtn setImage:closeImage forState:UIControlStateNormal];
    
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:closeBtn];

    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.left.equalTo(self.view).offset(20);
        make.size.mas_equalTo(CGSizeMake(15, 30));
        
    }];
*/    
    
    DeformationButton *loginBtn = [[DeformationButton alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width/1.5, 40)];
    
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    [loginBtn setTitle:@"login" forState:UIControlStateNormal];
        
    loginBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:loginBtn];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width/1.5, 40));
        make.centerX.equalTo(self.view);
        make.top.equalTo(pwdField.mas_bottom).offset(40);
        
    }];
    
    //sign up
    UILabel *alertLabel = [[UILabel alloc]init];
    
    alertLabel.text = @"No User?";
    
    alertLabel.textColor = [UIColor whiteColor];
    
    alertLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:WGiveFontSize(15)];
    
    alertLabel.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:alertLabel];
    
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(loginBtn.frame.size.width/2, 30));
        make.left.equalTo(loginBtn.mas_left);
        make.top.equalTo(loginBtn.mas_bottom).offset(30);
        
    }];
    
    UIButton *signUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [signUpBtn setTitle:@"Sign up" forState:UIControlStateNormal];
    
    [signUpBtn setTitleColor:[UIColor colorWithRed:0.7176 green:0.2118 blue:0.2667 alpha:1.0] forState:UIControlStateNormal];
    
    [signUpBtn setTitleColor:[UIColor colorWithRed:0.6515 green:0.1357 blue:0.2066 alpha:0.533783783783784] forState:UIControlStateHighlighted];
    
    signUpBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:WGiveFontSize(14)];
    
    [signUpBtn addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:signUpBtn];
    
    [signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(WGiveWidth(65), 30));
        make.left.equalTo(alertLabel.mas_right);
        make.top.equalTo(alertLabel);
        
    }];
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 登录处理
- (void)login:(DeformationButton *)button
{
    if (!button.isLoading) {
        
        [SVProgressHUD dismiss];
        
        return;
        
    }else{
    
        [SVProgressHUD show];
        //登录
        [BmobUser loginWithUsernameInBackground:_userName
                                       password:_pwd
                                          block:^(BmobUser *user, NSError *error) {
                                              
                                              if (user) {

                                                  UserModel *userModel = [UserModel configWithBombUser:user];
                                                      
                                                  [userModel downloadUserImageComplete:^{
                                                      
                                                      [SVProgressHUD showSuccessWithStatus:@"Login Success"];
                                                      
                                                      if (self.isRelogin) {
                                                          
                                                          [KLNotificationHelp postNotificationName:kLoginSuccessNotification object:nil];
                                                          
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                          
                                                      }else{
                                                          
                                                          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                              
                                                              UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                              
                                                              MainTabbarController *main = [storyBoard instantiateViewControllerWithIdentifier:@"MainTabBarID"];
                                                              
                                                              [self presentViewController:main animated:NO completion:nil];
                                                              
                                                          });
                                                          
                                                          
                                                      }
                                                      
                                                      
                                                  }];

                                            
                                                  
                                                  
                                              }else{
                                                  
                                                  [SVProgressHUD showErrorWithStatus:error.userInfo[@"error"]];
                                              }
                                              
                                          }];
    }

}


#pragma mark 调到注册页面
- (void)signUp
{
    SignUpViewController *signVC = [[SignUpViewController alloc]init];
    
    
    [self.navigationController pushViewController:signVC animated:YES];
    
}

- (void)hideKeyboard
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kHideKeyboardNotification object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kHideKeyboardNotification object:nil];
}

@end
