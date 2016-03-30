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
#import "UINavigationBar+Awesome.h"

@interface EditViewController ()<EditToolBarDelegate,UITextViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    UITextView *_textView;
    
    TitleTextfield *_titleField;
    
    NSString *_title;
    
    NSString *_content;
    
    NSString *_objId;

}

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation EditViewController

-(instancetype)initWithObjectId:(NSString *)objId
{
    self = [super init];
    
    if (self) {
        
        _objId = objId;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setNav];
    
    [self setupView];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[IQKeyboardManager sharedManager]setEnable:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar lt_setTitleTranslationY: 0];
    
    [self.navigationController.navigationBar lt_setTitleViewAlpha:1];
}

- (void)loadDetailComplete:(void(^)(BmobObject *object))complete
{
    [SVProgressHUD show];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:[[BmobUser getCurrentUser]objectForKey:@"userNoteTable"]];

    [bquery getObjectInBackgroundWithId:_objId block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                //得到playerName和cheatMode
                
                complete(object);
                [SVProgressHUD dismiss];
            }
        }
    }];
}

- (void)setNav
{
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"edit_correct"] style:UIBarButtonItemStylePlain target:self action:@selector(finish)];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"edit_more"] style:UIBarButtonItemStylePlain target:self action:@selector(more)];
    
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)setupView
{

    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    self.scrollView.delegate = self;
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView.contentOffset = CGPointMake(0, 64);
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.view.bounds.size.height);
    
    [self.view addSubview:self.scrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    
    [self.scrollView addGestureRecognizer:tap];
    
    NSArray *iconArr = @[@"iphone_keyBoardSwitch",@"edit_photo",@"edit_camera",@"edit_record",@"edit_heart"];

    EditToolBar *editBar = [[EditToolBar alloc]initWithIconArray:iconArr];
    
    editBar.delegate = self;
    
    [self.view addSubview:editBar];
    
    _titleField = [[TitleTextfield alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 60)];
    
    _titleField.delegate = self;
    
    _titleField.placeholder = @"Please enter your title";
    
    [self.scrollView addSubview:_titleField];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, _titleField.frame.origin.y+70, SCREEN_WIDTH-20, 200)];
    
    _textView.font = [UIFont fontWithName:@"ProximaNova-Light" size:WGiveFontSize(17)];

    _textView.delegate = self;
    
//    [self.scrollView addSubview:_textView];
    
    _textView.frame = CGRectMake ( 10 , _titleField.frame.origin.y+70 , SCREEN_WIDTH , _textView.contentSize.height );

    
    if (self.isShowDetail) {
        
        [self loadDetailComplete:^(BmobObject *object) {
           
            self.title = [object objectForKey:@"title"];
            
            _titleField.text = [object objectForKey:@"title"];
            
            _textView.text = [object objectForKey:@"note_content"];
            
        }];
    }
}

- (void)finish
{
    
    [SVProgressHUD show];
    
    NSString *newTable = [NSString stringWithFormat:@"%@_NoteTable",[BmobUser getCurrentUser].username];
    
    NSString *oldTable = [[BmobUser getCurrentUser]objectForKey:@"userNoteTable"];
    
    if (![oldTable isEqualToString:@""] && oldTable != nil) {
        
        [self uploadDataWithClassName:oldTable];
        
    }else{
        
        BmobUser *user = [BmobUser getCurrentUser];
        
        [user setObject:newTable forKey:@"userNoteTable"];
        
        [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            
            if (isSuccessful) {
                
                [self uploadDataWithClassName:newTable];

            }
            
        }];
        
        
    }

    
}

- (void)uploadDataWithClassName:(NSString *)className
{
    if (_title == nil || _content == nil || [_title isEqualToString:@""] || [_content isEqualToString:@""]) {
        
        [SVProgressHUD dismiss];
        
        if (self.isShowDetail) {
            
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        
    }else{
    
        NSDictionary *parameDic = @{@"title":_title,
                                    @"note_content":_content,
                                    @"content_image":@"",
                                    @"icon_image":@""};
        
        BmobObjectsBatch    *batch = [[BmobObjectsBatch alloc] init] ;
        
        [batch saveBmobObjectWithClassName:className parameters:parameDic];
        
        [batch batchObjectsInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            
            [SVProgressHUD dismiss];
            
            [KLNotificationHelp postNotificationName:kSaveSuccessNotification object:nil];
            
            if (self.isShowDetail) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
                
            }else{
            
                [self dismissViewControllerAnimated:YES completion:nil];
            
            }
            
        }];
        
    }
}

- (void)more
{
    
}

-(void)editToolBar:(EditToolBar *)editBar didClickAtIndex:(NSInteger)index
{
 
}

- (void)hideKeyBoard
{
    [_titleField resignFirstResponder];
}

#pragma mark textview 代理

- (void)textViewDidBeginEditing:(UITextView *)textView
{

}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    _content = textView.text;
    

}


#pragma mark textfield 代理

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _title = textField.text;
    
    self.title  = _title;

}

#pragma mark -scoreView代理

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y+64;
    
    
    if (offsetY >= 10 && offsetY <30) {
        
        _titleField.transform = CGAffineTransformMakeScale(1-(offsetY/50), 1-(offsetY/50));

    }else if(offsetY < 10){
        
         _titleField.transform = CGAffineTransformMakeScale(1, 1);
        
        [self.navigationController.navigationBar lt_setTitleTranslationY:30];
        
        [self.navigationController.navigationBar lt_setTitleViewAlpha:0];
        
        
    }else if (offsetY >=30 && offsetY <60){
        
        [self.navigationController.navigationBar lt_setTitleTranslationY: 30-(offsetY-30)];
        
        [self.navigationController.navigationBar lt_setTitleViewAlpha:(offsetY-30)/30];
    
    }else if(offsetY >= 60){
        
        [self.navigationController.navigationBar lt_setTitleTranslationY: 0];
        
        [self.navigationController.navigationBar lt_setTitleViewAlpha:1];
        
        _titleField.transform = CGAffineTransformMakeScale(0, 0);
    }
    
}

@end
