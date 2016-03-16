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


}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alreadyChecked
{
    
}

@end
