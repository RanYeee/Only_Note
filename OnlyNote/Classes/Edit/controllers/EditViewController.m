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

@interface EditViewController ()<EditToolBarDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    UITextView *_textView;
    
    NSString *_title;
    
    NSString *_content;
    
    NSString *_objId;
}
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
    
    [IQKeyboardManager sharedManager].canAdjustTextView = YES;
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

    NSArray *iconArr = @[@"iphone_keyBoardSwitch",@"edit_photo",@"edit_camera",@"edit_record",@"edit_heart"];

    EditToolBar *editBar = [[EditToolBar alloc]initWithIconArray:iconArr];
    
    editBar.delegate = self;
    
    [self.view addSubview:editBar];
    
    TitleTextfield *titleField = [[TitleTextfield alloc]initWithFrame:CGRectMake(10, 65, SCREEN_WIDTH-20, 60)];
    
    titleField.delegate = self;
    
    titleField.placeholder = @"Please enter your title";
    
    [self.view addSubview:titleField];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, titleField.frame.origin.y+70, SCREEN_WIDTH-20, 200)];
    
    _textView.font = [UIFont fontWithName:@"ProximaNova-Light" size:WGiveFontSize(17)];

    _textView.delegate = self;
    
    [self.view addSubview:_textView];
    
    _textView.frame = CGRectMake ( 10 , titleField.frame.origin.y+70 , SCREEN_WIDTH , _textView.contentSize.height );

    
    if (self.isShowDetail) {
        
        [self loadDetailComplete:^(BmobObject *object) {
           
            titleField.text = [object objectForKey:@"title"];
            
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
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
    
        NSDictionary *parameDic = @{@"title":_title,
                                    @"note_content":_content,
                                    @"content_image":@"",
                                    @"icon_image":@""};
        
        BmobObjectsBatch    *batch = [[BmobObjectsBatch alloc] init] ;
        
        [batch saveBmobObjectWithClassName:className parameters:parameDic];
        
        [batch batchObjectsInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            
            [SVProgressHUD dismiss];
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                [KLNotificationHelp postNotificationName:kSaveSuccessNotification object:nil];
                
            }];
            
            
        }];
        
    }
}

- (void)more
{
    
}

-(void)editToolBar:(EditToolBar *)editBar didClickAtIndex:(NSInteger)index
{
 
}

#pragma mark textview 代理

-(void)textViewDidEndEditing:(UITextView *)textView
{
    _content = textView.text;
}


#pragma mark textfield 代理

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _title = textField.text;
}

@end
