//
//  UserHeaderView.h
//  OnlyNote
//
//  Created by IMac on 16/3/15.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserHeaderDelegate <NSObject>

- (void)didClickUserIconImage;

@end

@interface UserHeaderView : UIView

@property (nonatomic ,strong) UIImage *userImage;

@property (nonatomic ,strong) UIImage *bgImage;

@property (nonatomic ,strong) NSString *userName;

@property (nonatomic ,weak) id <UserHeaderDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame
                andUserImage:(UIImage *)userImage
                 andUserName:(NSString *)userName
                  andBgImage:(UIImage *)bgImage;

-(void)resetBgImage:(UIImage *)image;

-(void)resetIconImage:(UIImage *)image;


@end
