//
//  LeftListView.h
//  OnlyNote
//
//  Created by IMac on 16/3/29.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftListView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,copy) NSArray *fileNameArr;

-(instancetype)initWithFrame:(CGRect)frame andFileNameArray:(NSArray *)nameArr;

@end
