//
//  RootViewController.m
//  OnlyNote
//
//  Created by IMac on 16/3/29.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "RootViewController.h"
#import "MainTabbarController.h"
#import "UIView+SHCZExt.h"
#import "LeftListView.h"

@interface RootViewController ()

{
    MainTabbarController *_barVC;
}

@property (nonatomic,assign) BOOL isOpen;

@end

@implementation RootViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.0118 green:0.1569 blue:0.2235 alpha:1.0];
    
    _isOpen = NO;
    
    [self addSubview];
    
    [self addRecognizer];
    
    [KLNotificationHelp addObserver:self selector:@selector(sildeToleft) name:@"sildeToLeft" object:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)sildeToleft
{
    
    CGAffineTransform  rightScopeTransform=CGAffineTransformTranslate(self.view.transform,[UIScreen mainScreen].bounds.size.width*0.75, 0);

    if (!_isOpen) {
        
        //打开
        
        [UIView animateWithDuration:0.2 animations:^{
            
            [self.view.subviews objectAtIndex:2].transform=rightScopeTransform;
            
            [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
    
        }];

    }else{
        
        //关闭
        
        [UIView animateWithDuration:0.2 animations:^{
            
        
            [self.view.subviews objectAtIndex:2].transform = CGAffineTransformIdentity;
            
            [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
            
        }];

    }
    
    _isOpen = !_isOpen;
    
}

- (void)addSubview {
    //在self.view上创建一个透明的View
    LeftListView *mainView=[[LeftListView alloc]initWithFrame:CGRectMake(-self.view.bounds.size.width*0.25,0,self.view.bounds.size.width,self.view.bounds.size.height) andFileNameArray:@[]];
    //设置冰川背景图
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    img.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    
    [self.view addSubview:img];
    
    //添加
    [self.view addSubview:mainView];
    
    [self addTabVC];
}


- (void)addTabVC
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    _barVC = (MainTabbarController *)[storyBoard instantiateViewControllerWithIdentifier:@"MainTabBarID"];
    
    [self addChildViewController:_barVC];
    
    _barVC.view.frame = self.view.bounds;
    
    [self.view addSubview:_barVC.view];
    

}

-(void)addRecognizer{
    //    添加拖拽
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPanEvent:)];
    
    [self.view addGestureRecognizer:pan];
}

//实现拖拽
-(void)didPanEvent:(UIPanGestureRecognizer *)recognizer{
    
    
    // 1. 获取手指拖拽的时候, 平移的值
    CGPoint translation = [recognizer translationInView:[self.view.subviews objectAtIndex:2]];
    // 2. 让当前控件做响应的平移
    [self.view.subviews objectAtIndex:2].transform = CGAffineTransformTranslate([self.view.subviews objectAtIndex:2].transform, translation.x, 0);
    
    CGFloat alphaOffset = [self.view.subviews objectAtIndex:2].transform.tx;
    
    [self.view.subviews objectAtIndex:1].alpha = 1-((240-alphaOffset)/240) ;
    
    [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
    
    // 3. 每次平移手势识别完毕后, 让平移的值不要累加
    [recognizer setTranslation:CGPointZero inView:[self.view.subviews objectAtIndex:2]];
    

    //获取最右边范围
    CGAffineTransform  rightScopeTransform=CGAffineTransformTranslate(self.view.transform,[UIScreen mainScreen].bounds.size.width*0.75, 0);
    
    //    当移动到右边极限时
    if ([self.view.subviews objectAtIndex:2].transform.tx>rightScopeTransform.tx) {
        
        //        限制最右边的范围
        [self.view.subviews objectAtIndex:2].transform=rightScopeTransform;
        //        限制透明view最右边的范围
        [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
        
        //        当移动到左边极限时
    }else if ([self.view.subviews objectAtIndex:2].transform.tx<0.0){

        //        限制最左边的范围
        [self.view.subviews objectAtIndex:2].transform=CGAffineTransformTranslate(self.view.transform,0, 0);
        //    限制透明view最左边的范围
        [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
        
    }
    //    当托拽手势结束时执行
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            if ([self.view.subviews objectAtIndex:2].x >[UIScreen mainScreen].bounds.size.width*0.5) {
                
                [self.view.subviews objectAtIndex:2].transform=rightScopeTransform;
                
                [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
                
                _isOpen = YES;
                
            }else{
                
                [self.view.subviews objectAtIndex:2].transform = CGAffineTransformIdentity;
                
                [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
                
                _isOpen = NO;
            }
        }];
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
