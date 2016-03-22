//
//  UserViewController.m
//  OnlyNote
//
//  Created by IMac on 16/3/11.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "UserViewController.h"
#import "UserHeaderView.h"
#import "ImageCropViewController.h"
#import "RNNavigationController.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "BmobHelp.h"
#import "UIImage+Addition.h"
#import "LoginViewController.h"

@interface UserViewController ()<UserHeaderDelegate,
                                 UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate,
                                 ImageCropDelegate>
{
    UserHeaderView *_headerView;
    
    UIImage *_bg_Image;
    
    UIImage *_icon_Image;
}
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"me";
    
    CGRect headRect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.9);
    
    
    _headerView = [[UserHeaderView alloc]initWithFrame:headRect andUserName:[BmobUser getCurrentUser].username];
    
    [self.view addSubview:_headerView];
    
    _headerView.delegate = self;
    

    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [logoutBtn addTarget:self action:@selector(logoutClick) forControlEvents:UIControlEventTouchUpInside];
    
    [logoutBtn setTintColor:[UIColor whiteColor]];
    
    [logoutBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:0.9871 green:0.2182 blue:0.2662 alpha:0.918523015202703]] forState:UIControlStateNormal];
    
    [logoutBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:0.9922 green:0.3137 blue:0.3294 alpha:1.0]] forState:UIControlStateHighlighted];
    
    [logoutBtn setTitle:@"logout" forState:UIControlStateNormal];
    
    logoutBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:WGiveFontSize(20)];;
    
    [self.view addSubview:logoutBtn];
    
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, WGiveHeight(40)));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-self.tabBarController.tabBar.frame.size.height);
        
    }];
  
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [KLNotificationHelp addObserver:self
                           selector:@selector(reloadHeadView)
                               name:kLoginSuccessNotification
                             object:nil];
}

-(void)reloadHeadView
{
    [_headerView reloadView];
}

#pragma mark - 点击事件
-(void)didClickUserIconImage
{
    //打开相册
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)logoutClick
{
    //退出登录
    [BmobUser logout];
    
    [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
        
        //回到登录界面
        
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        
        RNNavigationController *nav = [[RNNavigationController alloc]initWithRootViewController:loginVC];
        
        nav.navigationBar.hidden = YES;
        
        loginVC.isRelogin = YES;
        
        [self presentViewController:nav animated:YES completion:nil];
        
    }];
    


}

#pragma mark - 相册回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        
        //初始化
        ImageCropViewController *imageCropViewController=[[ImageCropViewController alloc] initWithImage:image];
        
        imageCropViewController.delegate=self;

        [self presentViewController:imageCropViewController animated:YES completion:nil];
        
    }];
    
}

#pragma mark - CDPImageCropDelegate
//确定
-(void)confirmClickWithBgImage:(UIImage *)bgImage andIconImage:(UIImage *)iconImage{
    
    BmobUser *bmobUser = [BmobUser getCurrentUser];
    
    NSData *bgData = UIImagePNGRepresentation(bgImage);
    
    NSData *iconData = UIImagePNGRepresentation(iconImage);
    
    NSDictionary *bgDic = @{@"filename": [NSString stringWithFormat:@"%@_bgImage.png",bmobUser.username],
                               @"data":bgData};
   
    NSDictionary *iconDic = @{@"filename":[NSString stringWithFormat:@"%@_iconImage.png",bmobUser.username],
                              @"data":iconData};
    
    NSArray *uploadArr = @[bgDic,iconDic];
    
    [BmobFile filesUploadBatchWithDataArray:uploadArr progressBlock:^(int index, float progress) {
        
        [SVProgressHUD showProgress:progress status:@"Uploading"];
        
    } resultBlock:^(NSArray *array, BOOL isSuccessful, NSError *error) {
        
        if (isSuccessful) {
                        
            BmobFile *file_bgImage = array[0];
            
            BmobFile *file_iconImage = array[1];
            
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            
            [manager saveImageToCache:bgImage forURL:[NSURL URLWithString:file_bgImage.url]];
            
            [manager saveImageToCache:iconImage forURL:[NSURL URLWithString:file_iconImage.url]];

            //url存到bmob
            
            NSString *userImage = [NSString stringWithFormat:@"%@;%@",file_bgImage.url,file_iconImage.url];
            
           
          
            [bmobUser setObject:userImage forKey:@"userImage"];
            
            
            [bmobUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                
                //显示裁剪后的图片
                if (isSuccessful) {
                    
                    
                    [self dismissViewControllerAnimated:YES completion:nil];

                    [_headerView resetBgImage:bgImage];
                    
                    [_headerView resetIconImage:iconImage];
                    
                    [SVProgressHUD dismiss];
                    
                }else{
                    
                    [SVProgressHUD showErrorWithStatus:@"Faile Upload"];
                    
                }
                
                
            }];
   

            
            
        }else{
            
            NSLog(@">>>>>>%@",error);
        }
        
    }];
    
}
//返回
-(void)backClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:kLoginSuccessNotification];
}

@end
