//
//  SYDCategoryTableViewCell.m
//  BaiJie
//
//  Created by ADMIN on 17/8/30.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDCategoryTableViewCell.h"
#import "SYDRecommendCategoryModel.h"
@interface SYDCategoryTableViewCell ()

@property (nonatomic, weak) UIButton * lineView;
@property (nonatomic, weak) UILabel * categoryLabel;
@property (nonatomic, weak) UIView * bottomLineView;

@end

static CGFloat const lineW = 5;
static CGFloat const lineMargin = 2;

@implementation SYDCategoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = SYDTableViewbackgroundColor;
        
        UILabel * categoryLabel = [[UILabel alloc] init];
        [self.contentView addSubview:categoryLabel];
        categoryLabel.font = [UIFont systemFontOfSize:14];
        self.categoryLabel = categoryLabel;
        
        UIButton *lineView = [[UIButton alloc] init];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = [UIColor redColor];
        self.lineView = lineView;
        
        
        UIView * bottomLineView = [[UIView alloc] init];
        [self.contentView addSubview:bottomLineView];
        bottomLineView.backgroundColor = [UIColor whiteColor];
        self.bottomLineView = bottomLineView;
        
    }
    return self;
}

- (void)setCategoryModel:(SYDRecommendCategoryModel *)categoryModel{
    _categoryModel = categoryModel;
    
    self.lineView.frame = CGRectMake(0, lineMargin, lineW, self.syd_height - 2*lineMargin);
    
    [self.categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(2);
        make.left.equalTo(self.lineView.mas_right).offset(2);
        make.bottom.offset(-2);
        make.right.offset(-2);
    }];
    self.categoryLabel.text = categoryModel.name;
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(0.5);
        make.bottom.offset(0);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.lineView.hidden = !selected;
    self.categoryLabel.textColor = selected ? self.lineView.backgroundColor : SYDGrayColor(78);
    
}

@end
