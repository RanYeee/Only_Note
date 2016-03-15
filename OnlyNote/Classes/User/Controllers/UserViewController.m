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

@interface UserViewController ()<UserHeaderDelegate,
                                 UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate,
                                 ImageCropDelegate>
{
    UserHeaderView *_headerView;
}
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"me";
    
    CGRect headRect = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH*9/16);

    _headerView = [[UserHeaderView alloc]initWithFrame:headRect andUserImage:[UIImage imageNamed:@"userImage.jpg"] andUserName:@"AnRan" andBgImage:[UIImage imageNamed:@"headerImage.jpeg"]];
    
    [self.view addSubview:_headerView];
    
    _headerView.delegate = self;
    

  
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
-(void)confirmClickWithImage:(UIImage *)image{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //显示裁剪后的图片
    [_headerView resetBgImage:image];
    
}
//返回
-(void)backClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
