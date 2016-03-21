//
//  UserModel.m
//  OnlyNote
//
//  Created by rany on 19/3/16.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "UserModel.h"
#import "SDWebImageManager.h"

@implementation UserModel

+(instancetype)configWithBombUser:(BmobUser *)user
{
    UserModel *model = [[UserModel alloc]init];
    
    if (user) {
        
        model.username = user.username;
        
        NSString *userImage = [user objectForKey:@"userImage"];
        
        NSArray *imageUrlArr = [userImage componentsSeparatedByString:@";"];
        
        model.bgImage_url = imageUrlArr[0];
        
        model.iconImage_url = imageUrlArr[1];
        
        model.userId = user.objectId;
        
    }
    
    return model;
}

- (void)downloadUserImageComplete:(void(^)())complete
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    if ([manager diskImageExistsForURL:[NSURL URLWithString:self.bgImage_url]]) {
        
        return;
        
    }else{
    
        [manager downloadImageWithURL:[NSURL URLWithString:self.bgImage_url]
                              options:SDWebImageContinueInBackground
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 
                                 
                             } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                 
                                 [manager downloadImageWithURL:[NSURL URLWithString:self.iconImage_url]
                                                       options:SDWebImageContinueInBackground
                                                      progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                          
                                                          
                                                      } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                          
                                                          
                                                          complete();
                                                          
                                                      }];
                                 
                                 
                             }];
        
    }
    
}


@end
