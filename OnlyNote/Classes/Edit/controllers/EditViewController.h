//
//  EditViewController.h
//  OnlyNote
//
//  Created by IMac on 16/3/22.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController

@property (nonatomic ,assign) BOOL isShowDetail;

- (instancetype)initWithObjectId:(NSString *)objId andFloderName:(NSString *)floderName;

@end
