//
//  EmailCheckViewController.m
//  OnlyNote
//
//  Created by IMac on 16/3/16.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "EmailCheckViewController.h"

@interface EmailCheckViewController ()

@end

@implementation EmailCheckViewController

-(instancetype)initWithEmail:(NSString *)email andUser:(BmobUser *)user
{
    self = [super init];
    
    if (self) {
        
        self.email = email;
        
        self.user = user;

    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    //back button
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [backBtn setImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(15, 30));
        make.top.equalTo(self.view).offset(WGiveHeight(40));
        make.left.equalTo(self.view).offset(WGiveWidth(20));
        
    }];

    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"Verify email has been sent to your mailbox, please check and verify";
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:17];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 50));
        make.top.equalTo(backBtn).offset(50);
        make.left.equalTo(self.view).offset(10);
        
    }];
    
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"send_email_big"]];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/4, SCREEN_WIDTH/4));
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-20);
        
    }];
    
    
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [checkBtn setTitle:@"Already Checked" forState:UIControlStateNormal];
    
    [checkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [checkBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    checkBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:18];
    
    [checkBtn addTarget:self action:@selector(alreadyChecked) forControlEvents:UIControlEventTouchUpInside];
    
    checkBtn.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    checkBtn.layer.borderWidth = 0.65f;
    
    [self.view addSubview:checkBtn];
    
    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(WGiveHeight(-150));
    }];

    
    UILabel *alertLabel = [[UILabel alloc]init];
    
    alertLabel.text = @"Not Receive?";
    
    alertLabel.textColor = [UIColor whiteColor];
    
    alertLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:WGiveFontSize(15)];
    
    alertLabel.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:alertLabel];
    
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/4, 30));
        make.left.equalTo(checkBtn.mas_left);
        make.top.equalTo(checkBtn.mas_bottom).offset(30);
        
    }];
    
    UIButton *signUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [signUpBtn setTitle:@"Re-Send" forState:UIControlStateNormal];
    
    [signUpBtn setTitleColor:[UIColor colorWithRed:0.7176 green:0.2118 blue:0.2667 alpha:1.0] forState:UIControlStateNormal];
    
    [signUpBtn setTitleColor:[UIColor colorWithRed:0.6515 green:0.1357 blue:0.2066 alpha:0.533783783783784] forState:UIControlStateHighlighted];
    
    signUpBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:WGiveFontSize(14)];
    
    [signUpBtn addTarget:self action:@selector(reSend) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:signUpBtn];
    
    [signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(WGiveWidth(65), 30));
        make.left.equalTo(alertLabel.mas_right);
        make.top.equalTo(alertLabel);
        
    }];

}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)reSend
{
    //重新发送email
    
    [self.user verifyEmailInBackgroundWithEmailAddress:self.email];
    
    [SVProgressHUD showSuccessWithStatus:@"Has been re-sent"];
    
}
- (void)alreadyChecked
{
    
    [SVProgressHUD show];
    
    [self.user userEmailVerified:^(BOOL isSuccessful, NSError *error) {
       
        if (isSuccessful) {
            
            
            [SVProgressHUD showSuccessWithStatus:@"Verify success"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            });
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"Validation failed"];

        }
        
    }];
}

@end
