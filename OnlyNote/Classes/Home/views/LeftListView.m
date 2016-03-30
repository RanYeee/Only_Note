//
//  LeftListView.m
//  OnlyNote
//
//  Created by IMac on 16/3/29.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "LeftListView.h"
#import "LeftViewCell.h"

@implementation LeftListView

-(instancetype)initWithFrame:(CGRect)frame andFileNameArray:(NSArray *)nameArr
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.fileNameArr = nameArr;
        
        
//        UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftview_Folder"]];
//        
//        iconView.frame = CGRectMake(0, 0, 225, 67.5);
//        
//        iconView.center = CGPointMake(frame.size.width*0.75*0.5, 60);
//        
//        [self addSubview:iconView];
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, frame.size.width, frame.size.height-120) style:UITableViewStylePlain];
        
        self.tableView.delegate = self;
        
        self.tableView.dataSource = self;
        
        self.tableView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.tableView];
    }
    
    return self;
}

#pragma mark - tabelView delegate & dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellId";
    
    LeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell = [[LeftViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        

    }
    
    cell.textLabel.text = @"hfiowheo";
    
    return cell;
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 44;
//    
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [KLNotificationHelp postNotificationName:@"sildeToLeft" object:nil];
    
    [KLNotificationHelp postNotificationName:@"selectOtherFloder" object:nil];
    
}

@end
