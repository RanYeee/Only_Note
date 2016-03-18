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
    
    CGRect headRect = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH*9/16);
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    NSString *bg_url = [userDef objectForKey:kUserBgImageCacheKey];
    
    NSString *icon_url = [userDef objectForKey:kUserIconImageCacheKey];
    

    
    if (!bg_url) {
        
        _bg_Image = [UIImage imageNamed:@"DefaultUserBackground.png"];
        
        _icon_Image = [UIImage imageNamed:@"DefaultUserIcon.png"];
        
    }else{
        
        _bg_Image = [[SDImageCache sharedImageCache]imageFromMemoryCacheForKey:bg_url];
        
        _icon_Image = [[SDImageCache sharedImageCache]imageFromMemoryCacheForKey:icon_url];

    }

    _headerView = [[UserHeaderView alloc]initWithFrame:headRect
                                          andUserImage:_icon_Image
                                           andUserName:@"Rany"
                                            andBgImage:_bg_Image];
    
    [self.view addSubview:_headerView];
    
    _headerView.delegate = self;
    
  
}

- (void)isSetUserImage:(void(^)())complete
{
    
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
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSData *bgData = UIImagePNGRepresentation(bgImage);
    
    NSData *iconData = UIImagePNGRepresentation(iconImage);
    
    NSDictionary *bgDic = @{@"filename":@"bgImage.png",
                               @"data":bgData};
    
    NSDictionary *iconDic = @{@"filename":@"iconImage.png",
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
            
            //存CacheKey
            NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
            
            [userDef setObject:file_bgImage.url forKey:kUserBgImageCacheKey];
            
            [userDef setObject:file_iconImage.url forKey:kUserIconImageCacheKey];
            
            [userDef synchronize];
            
            //url存到bmob
            
            NSString *userImage = [NSString stringWithFormat:@"%@;%@",file_bgImage.url,file_iconImage.url];
            
            BmobUser *bmobUser = [BmobUser getCurrentUser];
          
            [bmobUser setObject:userImage forKey:@"userImage"];
            
            
            [bmobUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                
                //显示裁剪后的图片
                if (isSuccessful) {
                    
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


//更新数据到bmob



@end
