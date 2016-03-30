//
//  LeftViewCell.m
//  OnlyNote
//
//  Created by IMac on 16/3/29.
//  Copyright © 2016年 IMac. All rights reserved.
//

#import "LeftViewCell.h"

@implementation LeftViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    


}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor=[UIColor clearColor];
        
        self.textLabel.textColor=[UIColor whiteColor];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    UIView *selectView = [[UIView alloc] initWithFrame:self.contentView.frame];
    
    selectView.backgroundColor = [UIColor colorWithRed:1.0 green:0.1961 blue:0.2314 alpha:1.0];
    
    selectView.alpha = 0.8;
    
    self.selectedBackgroundView = selectView;
}



@end
