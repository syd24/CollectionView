//
//  SYDSubTagsTableViewCell.m
//  BaiJie
//
//  Created by ADMIN on 17/7/31.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDSubTagsTableViewCell.h"

@implementation SYDSubTagsTableViewCell


- (void)setItem:(SYDSubTagsModel *)item{
    _item = item;

    _nameLabel.text = item.theme_name;
    NSInteger num = _item.sub_number.integerValue;
    _numLabel.text = (num > 10000) ? [[NSString stringWithFormat:@"%.1f万人订阅",num / 10000.0] stringByReplacingOccurrencesOfString:@".0" withString:@""]: [NSString stringWithFormat:@"%@人订阅",_item.sub_number];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:_item.image_list]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
