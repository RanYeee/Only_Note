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
#import "EmailCheckViewController.h"

@interface SignUpViewController ()<UITextFieldDelegate>
{
    NSString *_userName;
    NSString *_email;
    NSString *_password;
}
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

#pragma mark textfield Delegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            _userName = textField.text;
            
            break;
        case 1:
            
            _email = textField.text;
            break;
        case 2:
            
            _password = textField.text;
            break;
        default:
            break;
    }
    
}


#pragma mark 点击事件
-(void)createAccount
{
    EmailCheckViewController *checkVC = [[EmailCheckViewController alloc]init];
    
    [self.navigationController pushViewController:checkVC animated:YES];
    
//    UILabel *alertLabel;
//    
//    [alertLabel removeFromSuperview];
//    
//    if ([self isEmpty:_email] || [self isEmpty:_userName] || [self isEmpty:_password]) {
//        
//        alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.8, SCREEN_WIDTH, 30)];
//        alertLabel.hidden = NO;
//        alertLabel.text = @"Please fill in the form";
//        alertLabel.textAlignment = NSTextAlignmentCenter;
//        alertLabel.textColor = [UIColor colorWithRed:0.9939 green:0.2214 blue:0.2281 alpha:1.0];
//        alertLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
//        [self.view addSubview:alertLabel];
//        
//        
//        
//    }else{
//        
//        alertLabel.hidden = YES;
//        
//        //请求注册
//
//        BmobUser *bUser = [[BmobUser alloc] init];
//        [bUser setUsername:_userName];
//        [bUser setPassword:_password];
//
//        [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
//            if (isSuccessful){
//               NSLog(@">>>>>>success sign up");
//                //发送验证邮件
//                [bUser verifyEmailInBackgroundWithEmailAddress:_email];
//                //跳转到验证邮箱页面
//                
//                
//            } else {
//                
//                NSLog(@"%@",error);
//                
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:error.userInfo[@"error"] preferredStyle:UIAlertControllerStyleAlert];
//     
//                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
//                [alertController addAction:cancelAction];
//                
//                [self presentViewController:alertController animated:YES completion:nil];
//        
//            }
//        }];
//    }
//    
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)hideKeyboard
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kResignFirstResponderNotification object:nil];
}

-(BOOL)isEmpty:(NSString *)str
{
    if ([str isEqualToString:@""]) {
        
        return YES;
        
    }else{
        
        return NO;
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kResignFirstResponderNotification object:nil];
}


@end
