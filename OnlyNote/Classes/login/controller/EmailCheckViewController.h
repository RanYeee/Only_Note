//
//  EmailCheckViewController.h
//  OnlyNote
//
//  Created by IMac on 16/3/16.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmailCheckViewController : UIViewController

-(instancetype)initWithEmail:(NSString *)email andUser:(BmobUser *)user;

@property (nonatomic ,strong) NSString *email;

@property (nonatomic ,strong) BmobUser *user;

@end
