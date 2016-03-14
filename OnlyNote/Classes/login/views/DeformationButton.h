//
//  DeformationButton.h
//  OnlyNote
//
//  Created by IMac on 16/3/14.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeformationButton : UIButton

@property (nonatomic, assign) BOOL isLoading;;

- (void)stopAnimate;

@end
