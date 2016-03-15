//
//  UIImage+Addition.h
//  OnlyNote
//
//  Created by IMac on 16/3/15.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

-(UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
