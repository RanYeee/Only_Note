//
//  ImageCropViewController.m
//  OnlyNote
//
//  Created by IMac on 16/3/15.
//  Copyright © 2016年 IMac. All rights reserved.
//
#define CropImageHeight SCREEN_WIDTH/16*9
#define BlackViewHeight (SCREEN_HEIGHT/2-CropImageHeight/2)

#import "ImageCropViewController.h"

@interface ImageCropViewController ()
{
    UIImageView *_imageView;
    CGRect _oldImageViewFrame;
    
    UIView *_roundView;
    
    CGRect _roundRect;
    
    UIImage *_originalImage;
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
        
        _originalImage = image;
        
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
    
    _roundRect = CGRectMake(0, 0, SCREEN_WIDTH/3, SCREEN_WIDTH/3);
    _roundView = [[UIView alloc]initWithFrame:_roundRect];
    _roundView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.687605574324324];
    _roundView.alpha = 0.3;
    _roundView.layer.borderWidth = 2.0;
    _roundView.layer.borderColor = [[UIColor whiteColor]CGColor];
    _roundView.layer.cornerRadius = _roundView.frame.size.height/2;
    _roundView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-10);
    [self.view addSubview:_roundView];
    //拖动
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRoundView:)];
    [_roundView addGestureRecognizer:pan];

    
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
    UIPinchGestureRecognizer *imageV_pinchGR=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchImageView:)];
    
    UIPinchGestureRecognizer *round_pinchGR=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchRoundView:)];
    
    [_imageView addGestureRecognizer:imageV_pinchGR];
    
    [_roundView addGestureRecognizer:round_pinchGR];
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
    
    UIImage *bgImage=[self getImageFromImageView:_imageView withRect:CGRectMake(0,BlackViewHeight,SCREEN_WIDTH,CropImageHeight)];
    NSLog(@">>>>>>_roundRect = %@",NSStringFromCGRect(_roundRect));
    
    UIImage *iconImage = [self getImageFromImageView:_imageView withRect:_roundRect];

    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(confirmClickWithBgImage:andIconImage:)]) {
            [_delegate confirmClickWithBgImage:bgImage andIconImage:iconImage];
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
        [self changeRoundFrameForGestureView:panGR.view];
    }

}
//缩放
-(void)pinchImageView:(UIPinchGestureRecognizer *)pinchGR{
    pinchGR.view.transform = CGAffineTransformScale(pinchGR.view.transform,pinchGR.scale,pinchGR.scale);
    pinchGR.scale = 1;
    
    if (pinchGR.view.class == [UIImageView class]) {
        
        if (pinchGR.state == UIGestureRecognizerStateBegan) {
            //当缩放手势开始时候禁止圆圈拖动
            _roundView.hidden = YES;
        }else if (pinchGR.state==UIGestureRecognizerStateEnded){
            _roundView.hidden = NO;

        }

    }
    
    if (pinchGR.state==UIGestureRecognizerStateEnded) {
        
        if ((pinchGR.view.transform.a<1||pinchGR.view.transform.d<1)) {
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

-(void)pinchRoundView:(UIPinchGestureRecognizer *)pinchGR{
    
    pinchGR.view.transform = CGAffineTransformScale(pinchGR.view.transform,pinchGR.scale,pinchGR.scale);
    pinchGR.scale = 1.0;
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

    } completion:^(BOOL finished) {
        
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
    
    if (frame.origin.y< BlackViewHeight) {
        frame.origin.y=BlackViewHeight;
    }
    
    if (frame.origin.y+frame.size.height>(CropImageHeight+BlackViewHeight)) {
        frame.origin.y=CropImageHeight+BlackViewHeight - frame.size.height;
    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        view.frame=frame;
        
    } completion:^(BOOL finished) {
        
        _roundRect = frame;
        
    }];
}



- (UIImage*)ClipImageWithRect:(CGRect)Rect WithImageView:(UIImageView*)imageView{
    
    CGRect subRect=[self.view convertRect:Rect toView:imageView];

    //开启位图上下文
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 0);
    //创建大小等于剪切区域大小的封闭路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:subRect];
    //设置超出的内容不显示，
    [path addClip];
    //获取绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将图片渲染的上下文中
    [imageView.layer renderInContext:context];
    //获取上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭位图上下文
    UIGraphicsEndImageContext();
    
    //返回image
    
    return image;
}

@end
