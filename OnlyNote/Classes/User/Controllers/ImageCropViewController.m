//
//  ImageCropViewController.m
//  OnlyNote
//
//  Created by IMac on 16/3/15.
//  Copyright © 2016年 IMac. All rights reserved.
//
#define BlackViewHeight (SCREEN_HEIGHT/2-(SCREEN_WIDTH/16*9)/2)

#import "ImageCropViewController.h"

@interface ImageCropViewController ()
{
    UIImageView *_imageView;
    CGRect _oldImageViewFrame;
}

@end

@implementation ImageCropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

//初始化
-(instancetype)initWithImage:(UIImage *)image{
    if (self=[super init]) {
        _imageView=[[UIImageView alloc] initWithImage:image];
        
        [self createUI];
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    //    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor blackColor];
    self.navigationController.navigationBarHidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
}

#pragma mark - 创建UI
-(void)createUI{
    _imageView.userInteractionEnabled=YES;
    _imageView.contentMode=UIViewContentModeScaleToFill;
    
    CGSize imageSize=_imageView.image.size;
    
    if (imageSize.width>imageSize.height) {
        NSInteger width=(SCREEN_HEIGHT-BlackViewHeight*2)/imageSize.height*imageSize.width;
        _imageView.frame=CGRectMake(0,0,width,SCREEN_HEIGHT-BlackViewHeight*2);
        
        if (width<SCREEN_WIDTH) {
            _imageView.frame=CGRectMake(0,0,SCREEN_WIDTH,SCREEN_WIDTH/width*_imageView.bounds.size.height);
        }
    }
    else{
        NSInteger height=SCREEN_WIDTH/imageSize.width*imageSize.height;
        _imageView.frame=CGRectMake(0,0,SCREEN_WIDTH,height);
        
        if (height<SCREEN_HEIGHT-BlackViewHeight*2) {
            _imageView.frame=CGRectMake(0,0,(SCREEN_HEIGHT-BlackViewHeight*2)/height*_imageView.bounds.size.width,SCREEN_HEIGHT-BlackViewHeight*2);
        }
    }
    _imageView.center=[UIApplication sharedApplication].delegate.window.center;
    _oldImageViewFrame=_imageView.frame;
    
    [self.view addSubview:_imageView];
    
    UIView *roundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4, SCREEN_WIDTH/4)];
    roundView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.687605574324324];
    roundView.alpha = 0.3;
    roundView.layer.borderWidth = 1.0;
    roundView.layer.borderColor = [[UIColor whiteColor]CGColor];
    roundView.layer.cornerRadius = roundView.frame.size.height/2;
    roundView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-10);
    [self.view addSubview:roundView];
    //拖动
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRoundView:)];
    [roundView addGestureRecognizer:pan];
    
    
    UIView *topView=[[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,BlackViewHeight)];
    topView.backgroundColor=[UIColor blackColor];
    topView.alpha=0.7;
    topView.userInteractionEnabled=NO;
    [self.view addSubview:topView];
    
    UIView *footView=[[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-BlackViewHeight,SCREEN_WIDTH,BlackViewHeight)];
    footView.backgroundColor=[UIColor blackColor];
    footView.alpha=0.7;
    footView.userInteractionEnabled=NO;
    [self.view addSubview:footView];

    
    [self addGestureRecognizerToImageView];
    
    [self createTopBar];
}
//imageView添加手势
-(void)addGestureRecognizerToImageView{
    //拖动
    UIPanGestureRecognizer *panGR=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panImageView:)];
    [_imageView addGestureRecognizer:panGR];
    
    //缩放
    UIPinchGestureRecognizer *pinchGR=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchImageView:)];
    [_imageView addGestureRecognizer:pinchGR];
}
//创建导航栏
-(void)createTopBar{
    //返回
    UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(14,20+15,15,30)];
    [backButton setImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //确定
    UIButton *confirmButton=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-14-32,20+20,32,22)];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [confirmButton addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
}
#pragma mark - 点击事件
//返回
-(void)backClick{
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(backClick)]) {
            [_delegate backClick];
        }
        else{
            NSLog(@"CDPImageCropDelegate的backClick方法未设置");
        }
    }
    else{
        NSLog(@"CDPImageCropDelegate未设置");
    }
}
//确定
-(void)confirmClick{
    UIImage *image=[self getImageFromImageView:_imageView withRect:CGRectMake(0,BlackViewHeight,SCREEN_WIDTH,SCREEN_HEIGHT-BlackViewHeight*2)];
    //保存到本地相册
    UIImageWriteToSavedPhotosAlbum(image,nil,nil,nil);
    
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(confirmClickWithImage:)]) {
            [_delegate confirmClickWithImage:image];
        }
        else{
            NSLog(@"CDPImageCropDelegate的confirmClickWithImage:方法未设置");
        }
    }
    else{
        NSLog(@"CDPImageCropDelegate未设置");
    }
}
#pragma mark - 图片裁剪
//裁剪修改后的图片
-(UIImage *)getImageFromImageView:(UIImageView *)imageView withRect:(CGRect)rect{
    
    CGRect subRect=[self.view convertRect:rect toView:imageView];
    
    UIImage *changedImage=[self createChangedImageWithImageView:imageView];
    
    UIGraphicsBeginImageContext(subRect.size);
    
    [changedImage drawInRect:CGRectMake(-subRect.origin.x,-subRect.origin.y,changedImage.size.width,changedImage.size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
//创建修改后的图片
-(UIImage *)createChangedImageWithImageView:(UIImageView *)imageView{
    UIGraphicsBeginImageContext(imageView.bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [imageView.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark - 手势相关
//拖动
-(void)panImageView:(UIPanGestureRecognizer *)panGR{
    CGPoint translation = [panGR translationInView:self.view];
    panGR.view.center = CGPointMake(panGR.view.center.x+translation.x,panGR.view.center.y+translation.y);
    [panGR setTranslation:CGPointZero inView:self.view];
    
    if (panGR.state==UIGestureRecognizerStateEnded) {
        [self changeFrameForGestureView:panGR.view];
    }
}

-(void)panRoundView:(UIPanGestureRecognizer *)panGR{
    
    CGPoint translation = [panGR translationInView:self.view];
    panGR.view.center = CGPointMake(panGR.view.center.x+translation.x,panGR.view.center.y+translation.y);
    [panGR setTranslation:CGPointZero inView:self.view];
    
    if (panGR.state==UIGestureRecognizerStateEnded) {
        [self changeFrameForGestureView:panGR.view];
    }

}
//缩放
-(void)pinchImageView:(UIPinchGestureRecognizer *)pinchGR{
    pinchGR.view.transform = CGAffineTransformScale(pinchGR.view.transform,pinchGR.scale,pinchGR.scale);
    pinchGR.scale = 1;
    
    if (pinchGR.state==UIGestureRecognizerStateEnded) {
        if (pinchGR.view.transform.a<1||pinchGR.view.transform.d<1) {
            [UIView animateWithDuration:0.25 animations:^{
                pinchGR.view.transform=CGAffineTransformIdentity;
                pinchGR.view.frame=_oldImageViewFrame;
                pinchGR.view.center=[UIApplication sharedApplication].delegate.window.center;
            }];
        }
        else{
            [self changeFrameForGestureView:pinchGR.view];
        }
    }
}
//调整手势view的frame
-(void)changeFrameForGestureView:(UIView *)view{
    CGRect frame=view.frame;
    
    if (frame.origin.x>0) {
        frame.origin.x=0;
    }
    if (frame.origin.y>BlackViewHeight) {
        frame.origin.y=BlackViewHeight;
    }
    if (CGRectGetMaxX(frame)<SCREEN_WIDTH) {
        frame.origin.x=frame.origin.x+(SCREEN_WIDTH-CGRectGetMaxX(frame));
    }
    if (CGRectGetMaxY(frame)<(SCREEN_HEIGHT-BlackViewHeight)) {
        frame.origin.y=frame.origin.y+(SCREEN_HEIGHT-BlackViewHeight-CGRectGetMaxY(frame));
    }
    [UIView animateWithDuration:0.25 animations:^{
        view.frame=frame;
    }];
    
}

- (void)changeRoundFrameForGestureView:(UIView *)view
{
    CGRect frame=view.frame;
    
    if (frame.origin.x<0) {
        frame.origin.x=0;
    }
    if (frame.origin.x+frame.size.width>SCREEN_WIDTH) {
        frame.origin.x = SCREEN_WIDTH - frame.size.width;
    }
    if (frame.origin.y>BlackViewHeight) {
        frame.origin.y=BlackViewHeight;
    }
    if (CGRectGetMaxX(frame)<SCREEN_WIDTH) {
        frame.origin.x=frame.origin.x+(SCREEN_WIDTH-CGRectGetMaxX(frame));
    }
    if (CGRectGetMaxY(frame)<(SCREEN_HEIGHT-BlackViewHeight)) {
        frame.origin.y=frame.origin.y+(SCREEN_HEIGHT-BlackViewHeight-CGRectGetMaxY(frame));
    }
    [UIView animateWithDuration:0.25 animations:^{
        view.frame=frame;
    }];

}


@end
