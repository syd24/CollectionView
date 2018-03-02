//
//  SYDMeTableViewCell.m
//  BaiJie
//
//  Created by ADMIN on 17/7/6.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDMeTableViewCell.h"
@implementation SYDMeTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.textColor = [UIColor darkGrayColor];
        
        //设置cell背景图片
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.imageView.image == nil) {
        return;
    }
    self.imageView.syd_y = 5;
    self.imageView.syd_height = self.contentView.syd_height - 2 * self.imageView.syd_y;
    self.imageView.syd_width = self.imageView.syd_height;
    
    self.textLabel.syd_x = CGRectGetMaxX(self.imageView.frame) + 10;
}
@end
