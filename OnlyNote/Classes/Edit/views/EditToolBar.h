//
//  EditToolBar.h
//  OnlyNote
//
//  Created by IMac on 16/3/22.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditToolBar;

@protocol EditToolBarDelegate <NSObject>

- (void)editToolBar:(EditToolBar *)editBar didClickAtIndex:(NSInteger)index;

@end

@interface EditToolBar : UIView

@property (nonatomic ,copy) NSArray <NSString *> *iconArray;

@property (nonatomic ,weak) id <EditToolBarDelegate> delegate;


-(instancetype)initWithIconArray:(NSArray <UIImage *> *)iconArr;

-(instancetype)initWithFrame:(CGRect)frame andIconArray:(NSArray <UIImage *>*)iconArr;

@end
