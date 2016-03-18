//
//  HomeViewController.m
//  OnlyNote
//
//  Created by IMac on 16/3/11.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "HomeViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MyCollectionViewCell.h"
#import "UIColor+Hex.h"
#import "CreateNewViewController.h"
#import "StickCollectionViewFlowLayout.h"
#import "LoginViewController.h"
#import "RNNavigationController.h"
#import <MJRefresh.h>
#import "NoteTabelModel.h"
#import "BmobHelp.h"

static const CGFloat kCellSizeCoef = .8f;
static const CGFloat kFirstItemTransform = 0.1f;

@interface HomeViewController ()<UICollectionViewDataSource,
                                 UICollectionViewDelegate,
                                 DZNEmptyDataSetSource,
                                 DZNEmptyDataSetDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dateArray;

@property (strong, nonatomic) NSArray *colorsArray;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Home";
    
    self.collectionView.emptyDataSetSource = self;
    
    self.collectionView.emptyDataSetDelegate = self;
    
    self.dateArray = [NSMutableArray array];
    
    self.colorsArray = @[@"EE5464", @"DC4352", @"FD6D50", @"EA583F", @"F6BC43", @"8DC253", @"4FC2E9", @"3CAFDB", @"5D9CEE", @"4B89DD", @"AD93EE", @"977BDD", @"EE87C0", @"D971AE", @"903FB1", @"9D56B9", @"227FBD", @"2E97DE"];
    
    [self setNav];
    
    StickCollectionViewFlowLayout *stickLayout = (StickCollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    stickLayout.firstItemTransform = kFirstItemTransform;
    
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0.263 green:0.310 blue:0.365 alpha:1.000];
    
    //刷新控件
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDate)];
    
    [self.collectionView.mj_header beginRefreshing];

    
}

#pragma mark 设置nav
- (void)setNav {
    
    //加号
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbuttonicon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(pushToCreateVC)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
}


- (void)pushToCreateVC
{
    
    BmobUser *user = [BmobUser getCurrentUser];
    
    if (user) {
    
        CreateNewViewController *createVC = [[CreateNewViewController alloc]init];
    
        createVC.hidesBottomBarWhenPushed = YES;
    
        [self.navigationController pushViewController:createVC animated:YES];
        
    }else{
        //无用户登录
        
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        
        RNNavigationController *nav = [[RNNavigationController alloc]initWithRootViewController:loginVC];
        
        nav.navigationBar.hidden = YES;
        
        [self presentViewController:nav animated:YES completion:nil];
        
    }

}

#pragma mark 加载数据/刷新列表

- (void)loadDate
{
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"NoteTable"];
    //查找GameScore表的数据
    
    bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            //打印playerName
            
            [self.dateArray addObject:[NoteTabelModel configWithBmobObject:obj]];
            
            [self.collectionView.mj_header endRefreshing];
            
            [self.collectionView reloadData];
        }
    }];
    
}

- (void)refresh
{

    
    
}

#pragma mark 列表为空的背景——delegate/datesource

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return  [UIImage imageNamed:@"placeholder_vesper"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"NO Note";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:23.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSString *text = @"Click here to star a new note";
    
    UIFont *font = [UIFont systemFontOfSize:16.0];
    
    UIColor *textColor = [UIColor colorFromHexString:(state == UIControlStateNormal) ? @"3DC5B8" : @"c6def9"];
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    [attributes setObject:font forKey:NSFontAttributeName];
    
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    
    [self pushToCreateVC];
}


#pragma mark CollectionView datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dateArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"myCellID";
    
    MyCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
//    NSString *hexString =self.colorsArray[indexPath.row];
//    UIColor *color = [UIColor colorFromHexString:hexString];
//    cell.bgView.backgroundColor = color;
    
    NoteTabelModel *model = self.dateArray[indexPath.row];
    
    cell.titleLabel.text = model.title;
    
    cell.detailTitleLabel.text = model.note_content;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@">>>>>>%ld",(long)indexPath.row);
}

#pragma mark -=CollectionView layout=-
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.collectionView.bounds) * kCellSizeCoef);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


@end
