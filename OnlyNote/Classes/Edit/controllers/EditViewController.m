//
//  EditViewController.m
//  OnlyNote
//
//  Created by IMac on 16/3/22.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "EditViewController.h"
#import "EditToolBar.h"
#import "TitleTextfield.h"
#import "IQKeyboardManager.h"

@interface EditViewController ()<EditToolBarDelegate,UITextViewDelegate>
{
    UITextView *_textView;
    
}
@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    
    [self setupView];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].canAdjustTextView = YES;
}

- (void)setNav
{
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"edit_correct"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"edit_more"] style:UIBarButtonItemStylePlain target:self action:@selector(more)];
    
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)setupView
{

    NSArray *iconArr = @[@"iphone_keyBoardSwitch",@"edit_photo",@"edit_camera",@"edit_record",@"edit_heart"];

    EditToolBar *editBar = [[EditToolBar alloc]initWithIconArray:iconArr];
    
    editBar.delegate = self;
    
    [self.view addSubview:editBar];
    
    TitleTextfield *titleField = [[TitleTextfield alloc]initWithFrame:CGRectMake(10, 65, SCREEN_WIDTH-20, 60)];
    
    titleField.placeholder = @"Please enter your title";
    
    [self.view addSubview:titleField];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, titleField.frame.origin.y+70, SCREEN_WIDTH-20, 200)];
    

    _textView.delegate = self;
    
    [self.view addSubview:_textView];
    
    _textView.frame = CGRectMake ( 10 , titleField.frame.origin.y+70 , SCREEN_WIDTH , _textView.contentSize.height );

    
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)more
{
    
}

-(void)editToolBar:(EditToolBar *)editBar didClickAtIndex:(NSInteger)index
{
 
}

#pragma mark textview 代理


@end
