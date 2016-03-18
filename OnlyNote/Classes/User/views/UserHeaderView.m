//
//  UserHeaderView.m
//  OnlyNote
//
//  Created by IMac on 16/3/15.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "UserHeaderView.h"
#import "UIImage+Addition.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "LoginViewController.h"
#import "RNNavigationController.h"

@interface UserHeaderView ()

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIImageView *iconImageV;

@property (nonatomic, strong) UILabel *userLabel;

@property (nonatomic ,strong) UIImage *userImage;

@property (nonatomic ,strong) UIImage *bgImage;



@end

@implementation UserHeaderView

-(instancetype)initWithFrame:(CGRect)frame
                 andUserName:(NSString *)userName
{
    self = [super initWithFrame:frame];
    
    if (self) {

        self.userName = userName;
        [self isSetUserImageComplete:^{
            
             [self setupview];
        }];
       
    }
    
    return self;
}

- (void)setupview
{
    //背景图
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    
    UIImage *bgImage = [self.bgImage applyBlurWithRadius:5 tintColor:[UIColor clearColor] saturationDeltaFactor:1.0 maskImage:nil];
    
//    [[UIImage alloc]applyBlurWithRadius:5 tintColor:self.tintColor saturationDeltaFactor:1.8 maskImage:nil];
    
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _bgImageView.image = bgImage;
    
    [self addSubview:_bgImageView];
    
    //圆形头像
    CGFloat iconH = self.frame.size.width/4;
    
    _iconImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, iconH, iconH)];
    
    _iconImageV.userInteractionEnabled = YES;
    
    _iconImageV.contentMode = UIViewContentModeScaleAspectFill;
    
//    self.userImage = [self circleImage:self.userImage withParam:0];
    
    _iconImageV.clipsToBounds = YES;
    
    _iconImageV.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _iconImageV.layer.borderWidth = 2.0f;
    
    _iconImageV.layer.cornerRadius = iconH/2;
//
    _iconImageV.image = self.userImage;
    
    _iconImageV.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-10);
    
    [self addSubview:_iconImageV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIconImage)];
    
    [_iconImageV addGestureRecognizer:tap];
    
    //username
    
    _userLabel = [[UILabel alloc]init];
    
    _userLabel.text = self.userName;
    
    _userLabel.textColor = [UIColor whiteColor];
    
    _userLabel.textAlignment = NSTextAlignmentCenter;
    
    _userLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:WGiveFontSize(18)];
    
    [self addSubview:_userLabel];
    
    [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width,35));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_iconImageV.mas_bottom).offset(15);
        
    }];
    
    
}


- (UIImage*)circleImage:(UIImage*) image withParam:(CGFloat) inset {
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    //圆的边框宽度为2，颜色为白色
    
    CGContextSetLineWidth(context,10);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset *2.0f, image.size.height - inset *2.0f);
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    //在圆区域内画出image原图
    
    [image drawInRect:rect];
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextStrokePath(context);
    
    //生成新的image
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newimg;
    
}

- (void)tapIconImage
{
    if (self.delegate) {
        
        [self.delegate didClickUserIconImage];
    }
}


//-(void)setBgImage:(UIImage *)bgImage
//{
//    _bgImageView.image = bgImage;
//}
//
//-(void)setUserName:(NSString *)userName
//{
//    _userLabel.text = userName;
//    
//}
//
//-(void)setUserImage:(UIImage *)userImage
//{
//    _iconImageV.image = userImage;
//}

-(void)resetBgImage:(UIImage *)image
{
    UIImage *resetImage = [image applyBlurWithRadius:5.0 tintColor:[UIColor clearColor] saturationDeltaFactor:1.0 maskImage:nil];
    
    _bgImageView.image = resetImage;

}

-(void)resetIconImage:(UIImage *)image
{
//    UIImage *resetImage = [self circleImage:image withParam:0];
    
    _iconImageV.image = image;
}

- (void)isSetUserImageComplete:(void(^)())complete
{
    BmobUser *user = [BmobUser getCurrentUser];
    
    if (user) {
        
        NSString *userImage = [user objectForKey:@"userImage"];
        
        NSString *bg_cacheKey = [[NSUserDefaults standardUserDefaults]objectForKey:kUserBgImageCacheKey];
        
        NSString *icon_cacheKey = [[NSUserDefaults standardUserDefaults]objectForKey:kUserIconImageCacheKey];
        
        if (userImage && ![userImage isEqualToString:@""]) {
            
            if (bg_cacheKey) {
                //有缓存
                self.bgImage = [[SDImageCache sharedImageCache]imageFromMemoryCacheForKey:bg_cacheKey];
                
                self.userImage = [[SDImageCache sharedImageCache]imageFromMemoryCacheForKey:icon_cacheKey];
                
                complete();
                
            }else{
                
                //无缓存,进行缓存操作
                
                [SVProgressHUD show];
                
                NSArray *imageUrlArr = [userImage componentsSeparatedByString:@";"];
                
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                
                __weak __typeof(&*self)weakSelf = self;
                
                    [manager downloadImageWithURL:[NSURL URLWithString:imageUrlArr[0]]
                                          options:SDWebImageContinueInBackground
                                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                             
                                             
                                         } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                             
                                             weakSelf.bgImage = image;
                                             
                                             [manager downloadImageWithURL:[NSURL URLWithString:imageUrlArr[1]]
                                                                   options:SDWebImageContinueInBackground
                                                                  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                                      
                                                                      
                                                                  } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                                      
                                                                      weakSelf.userImage = image;
                                                                      
                                                                      
                                                                      complete();
                                                                      
                                                                  }];

                                             
                                         }];
                    
                
                    
                
                [SVProgressHUD dismiss];
                
                
            }
            
           
            

        }else{
            
            //用户无设置头像和背景
            
            self.bgImage = [UIImage imageNamed:@"DefaultUserBackground.png"];
            
            self.userImage = [UIImage imageNamed:@"DefaultUserIcon.png"];
            
            complete();
            
        }
        
        
        
        
    }else{
        
        //登录过期
      
        self.bgImage = [UIImage imageNamed:@"DefaultUserBackground.png"];
        
        self.userImage = [UIImage imageNamed:@"DefaultUserIcon.png"];
        
        complete();
        
    }

}
@end
