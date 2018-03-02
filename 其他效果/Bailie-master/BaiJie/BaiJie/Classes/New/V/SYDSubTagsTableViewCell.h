//
//  SYDSubTagsTableViewCell.h
//  BaiJie
//
//  Created by ADMIN on 17/7/31.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SYDSubTagsModel.h"

@interface SYDSubTagsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (nonatomic, strong) SYDSubTagsModel *item;

@end
