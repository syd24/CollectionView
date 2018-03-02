//
//  SYDRecommendedPeopleTableViewCell.m
//  BaiJie
//
//  Created by ADMIN on 17/8/30.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDRecommendedPeopleTableViewCell.h"
#import "SYDRecommendUserModel.h"
@interface SYDRecommendedPeopleTableViewCell ()

@property (nonatomic, weak) UIImageView *headImageView;
@property (nonatomic, weak) UILabel * nameLabel;
@property (nonatomic, weak) UILabel * followerLabel;
@property (nonatomic, weak) UIButton * followBtn;

@end


@implementation SYDRecommendedPeopleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:headImageView];
        self.headImageView = headImageView;
        
        UILabel * nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:nameLabel];
        nameLabel.font = [UIFont systemFontOfSize:15];
        [nameLabel sizeToFit];
        self.nameLabel = nameLabel;
        
        UILabel * followerLabel = [[UILabel alloc] init];
        [self.contentView addSubview:followerLabel];
        followerLabel.font = [UIFont systemFontOfSize:13];
        [followerLabel sizeToFit];
        self.followerLabel = followerLabel;
        
        UIButton * followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:followBtn];
        self.followBtn = followBtn;
    }
    return self;
}

- (void)setUserModel:(SYDRecommendUserModel *)userModel{
    _userModel = userModel;
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-5);
        make.left.offset(5);
        make.size.sizeOffset(CGSizeMake(60, 60));
    }];
    [self.headImageView setHeader:userModel.header];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(8);
        make.top.offset(10);
    }];
    self.nameLabel.text = userModel.screen_name;
    
    [self.followerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(8);
        make.bottom.offset(-10);
    }];
    
    NSString *follows = @"";
    if (userModel.fans_count < 10000) {
        follows = [NSString stringWithFormat:@"%zd人关注",userModel.fans_count];
    }else{
        follows = [NSString stringWithFormat:@"%.1f万人关注", userModel.fans_count / 10000.0];
    }
    self.followerLabel.text = follows;
    
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.right.offset(-15);
        make.size.sizeOffset(CGSizeMake(60, 30));
    }];
    [self.followBtn setBackgroundImage:[UIImage imageNamed:@"FollowBtnBg"] forState:UIControlStateNormal];
    [self.followBtn setTitle:@"+  关注" forState:UIControlStateNormal];
    [self.followBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.followBtn.titleLabel.font = [UIFont systemFontOfSize:13];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
