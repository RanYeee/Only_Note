//
//  DeformationButton.m
//  OnlyNote
//
//  Created by IMac on 16/3/14.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "DeformationButton.h"

@interface DeformationButton()

{
    CGFloat _defaultW;
    CGFloat _defaultH;
    CGFloat _defaultR;
    CGFloat _scale;
}

@property (nonatomic, strong) UILabel *textLabel;



@end

@implementation DeformationButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self setup];
        
    }
    return self;
}

- (void)setup
{
    _isLoading = NO;
    
    _scale = 1.2;
    
    self.layer.cornerRadius = self.frame.size.height/2;
    
    self.clipsToBounds = YES;
    
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    self.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:20];
    
    self.alpha = 0.75f;
    
    _defaultW = self.frame.size.width;
    _defaultH = self.frame.size.height;
    _defaultR = self.layer.cornerRadius;
    
    [self addTarget:self action:@selector(startAnimate) forControlEvents:UIControlEventTouchUpInside];
    
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        
        _textLabel = [[UILabel alloc]initWithFrame:self.frame];
        
        _textLabel.text = @"cancle";
        
        _textLabel.textColor = [UIColor darkGrayColor];
        
        _textLabel.font = [UIFont systemFontOfSize:17];
        
        _textLabel.textAlignment = NSTextAlignmentCenter;
        
        _textLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _textLabel;
}


- (void)startAnimate
{
    if (!_isLoading) {
        
        self.userInteractionEnabled = NO;
        
        _isLoading = YES;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionLinear];
        animation.fromValue = [NSNumber numberWithFloat:_defaultR];
        animation.toValue   = [NSNumber numberWithFloat:_defaultH * 0.5];
        animation.duration  = 0.3;
        [self.layer setCornerRadius:_defaultH * 0.5];
        [self.layer addAnimation:animation forKey:@"cornerRadius"];
        
        [UIView animateWithDuration:0.4
                              delay:0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             CGRect newRect = self.layer.bounds;
                             newRect.size.width  = _defaultW * 0.3;
                             newRect.size.height = _defaultH;
                             self.layer.bounds   = newRect;
                             
                         } completion:^(BOOL finished) {
                             
                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 
                                 self.userInteractionEnabled = YES;
                                                                  
                             });
                             
                         }];
        
    }else
    {
        [self stopAnimate];
    }
    
}

- (void)stopAnimate
{
    if (_isLoading == YES) {
        
        self.userInteractionEnabled = NO;
        
        _isLoading = NO;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.fromValue = [NSNumber numberWithFloat:self.layer.cornerRadius];
        animation.toValue   = [NSNumber numberWithFloat:_defaultR];
        animation.duration  = 0.3;
        
        [self.layer setCornerRadius:_defaultR];
        [self.layer addAnimation:animation forKey:@"cornerRadius"];
        
        [UIView animateWithDuration:0.4
                              delay:0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             self.layer.bounds = CGRectMake(0, 0, _defaultW, _defaultH);
                             
                         } completion:^(BOOL finished) {
                             
                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 
                                 self.userInteractionEnabled = YES;
                                 

                             });
                             
                         }];
    }
}


@end
