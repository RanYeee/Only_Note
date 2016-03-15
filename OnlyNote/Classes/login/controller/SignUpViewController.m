//
//  SignUpViewController.m
//  OnlyNote
//
//  Created by IMac on 16/3/14.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "SignUpViewController.h"
#import "LoginTextfield.h"
#import "UIImage+Addition.h"

@interface SignUpViewController ()<UITextFieldDelegate>

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *bgImage =  [UIImage boxblurImage:[UIImage imageNamed:@"signupBg.JPG"] withBlurNumber:0.9f];
    
    UIImageView *bgImageV = [[UIImageView alloc]initWithImage:bgImage];
    
    bgImageV.userInteractionEnabled = YES;
    
    bgImageV.contentMode = UIViewContentModeScaleAspectFill;
    
    bgImageV.frame = self.view.bounds;
    
    [self.view addSubview:bgImageV];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    
    [bgImageV addGestureRecognizer:tapGesture];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.text = @"Sign Up";
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:WGiveFontSize(24)];
    
    [self.view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, WGiveHeight(50)));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(WGiveHeight(80));
        
    }];
    
    //back button
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [backBtn setImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(15, 30));
        make.top.equalTo(self.view).offset(WGiveHeight(30));
        make.left.equalTo(self.view).offset(WGiveWidth(20));
        
    }];
    
    //textfield
    NSArray *holderArr = @[@"Username",@"Email",@"Password"];
    
    [holderArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        LoginTextfield *textField = [[LoginTextfield alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/1.5, 40)];
        
        textField.placeholder = obj;
        
        textField.delegate = self;
        
        textField.tag = idx;
        
        [self.view addSubview:textField];
        
        textField.center = CGPointMake(self.view.center.x, (self.view.center.y-WGiveHeight(95))+idx*60);
        
    }];
    
    //register button
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [registBtn setTitle:@"Create an account" forState:UIControlStateNormal];
    
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [registBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    registBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:18];
    
    [registBtn addTarget:self action:@selector(createAccount) forControlEvents:UIControlEventTouchUpInside];
    
    registBtn.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    registBtn.layer.borderWidth = 0.65f;
    
    [self.view addSubview:registBtn];
    
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(WGiveHeight(-150));
    }];
}

-(void)createAccount
{
    
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)hideKeyboard
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kResignFirstResponderNotification object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kResignFirstResponderNotification object:nil];
}


@end
