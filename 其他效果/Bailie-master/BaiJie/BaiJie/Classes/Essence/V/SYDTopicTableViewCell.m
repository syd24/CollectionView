//
//  SYDTopicTableViewCell.m
//  BaiJie
//
//  Created by ADMIN on 17/8/24.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDTopicTableViewCell.h"
#import "SYDTopicModel.h"
#import "UIImageView+WebCache.h"
#import "SYDPictureView.h"
#import "SYDVideoView.h"
#import "SYDVoiceView.h"
@interface SYDTopicTableViewCell()

@property (nonatomic, weak)UIImageView * headImage;
@property (nonatomic, weak)UIImageView * certificationImage;
@property (nonatomic, weak)UILabel * userNameLabel;
@property (nonatomic, weak)UILabel * timeTextLabel;
@property (nonatomic, weak)UILabel * _textLabel;
@property (nonatomic, weak)UIButton * reportBtn;


@property (nonatomic, weak)UIView *botttomBgView;
@property (nonatomic, strong)NSMutableArray <UIButton *> *btns;


@property (nonatomic, strong)NSMutableArray <NSString *> *imageNames;
@property (nonatomic, strong)NSMutableArray <NSString *> *titles;
@property (nonatomic, strong)NSMutableArray *btnTitles;


@property (nonatomic, weak) SYDPictureView * pictureView;
@property (nonatomic, weak) SYDVideoView * videoView;
@property (nonatomic, weak) SYDVoiceView * voiceView;

@end

@implementation SYDTopicTableViewCell

//图片
- (SYDPictureView *)pictureView{
    if (_pictureView == nil) {
        SYDPictureView *pictureView = [[SYDPictureView alloc] init];
        [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
    }
    return _pictureView;
}

//视频
- (SYDVideoView *)videoView{
    if (_videoView == nil) {
        SYDVideoView *videoView = [[SYDVideoView alloc] init];
        [self.contentView addSubview:videoView];
        self.videoView = videoView;
    }
    return _videoView;
}

//声音
- (SYDVoiceView *)voiceView{
    if (_voiceView == nil) {
        SYDVoiceView *voiceView = [[SYDVoiceView alloc] init];
        [self.contentView addSubview:voiceView];
        self.voiceView = voiceView;
    }
    return _voiceView;
}




- (NSMutableArray<NSString *> *)imageNames{
    if (_imageNames == nil) {
        _imageNames = [NSMutableArray arrayWithObjects:@"mainCellDing",@"mainCellCai",@"mainCellShare",@"mainCellComment", nil];
    }
    return _imageNames;
}

- (NSMutableArray<NSString *> *)titles{
    if (_titles == nil) {
        _titles = [NSMutableArray arrayWithObjects:@"顶",@"踩",@"分享",@"转发", nil];

    }
    return _titles;
}

- (NSMutableArray *)btnTitles{
    if (_btnTitles == nil) {
        _btnTitles = [NSMutableArray array];
    }
    return _btnTitles;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //头像
        UIImageView *headImage = [[UIImageView alloc] init];
        [self.contentView addSubview:headImage];
        self.headImage = headImage;
        
        //人物认证
        UIImageView *certificationImage = [[UIImageView alloc] init];
        [headImage addSubview:certificationImage];
        certificationImage.image = [UIImage imageNamed:@"Profile_AddV_authen"];
        certificationImage.contentMode = UIViewContentModeScaleAspectFit;
        self.certificationImage = certificationImage;
        
        //名字
        UILabel *userNameLabel = [[UILabel alloc] init];
        userNameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:userNameLabel];
        [userNameLabel sizeToFit];
        userNameLabel.font = [UIFont systemFontOfSize:16];
        self.userNameLabel = userNameLabel;
        
        //发帖时间
        UILabel * timeTextLabel = [[UILabel alloc] init];
        [self.contentView addSubview:timeTextLabel];
        timeTextLabel.font = [UIFont systemFontOfSize:12];
        [timeTextLabel sizeToFit];
        self.timeTextLabel = timeTextLabel;
        
        //反馈按钮
        UIButton *reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:reportBtn];
        [reportBtn setImage:[UIImage imageNamed:@"cellmorebtnnormal"] forState:UIControlStateNormal];
        self.reportBtn = reportBtn;
        
        
        
        
        //内容
        UILabel *_textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.numberOfLines = 0;
        [self.contentView addSubview:_textLabel];
        self._textLabel = _textLabel;
        
        UIView * botttomBgView = [[UIView alloc] init];
        [self.contentView addSubview:botttomBgView];
        self.botttomBgView = botttomBgView;
        
        NSMutableArray *btns = [NSMutableArray array];
        for (int i = 0; i < self.imageNames.count; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [botttomBgView addSubview:btn];
            [btn setImage:[UIImage imageNamed:self.imageNames[i]] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
            [btns addObject:btn];
            self.btns = btns;
        }
        
        
       
       

        
    }
    return self;
}


- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)
placeholder{
    
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
    
}

- (void)setTopicModel:(SYDTopicModel *)topicModel{
    _topicModel = topicModel;
    
    //头像
    self.headImage.frame = CGRectMake(Margin, Margin, 50, 50);
    [self.headImage setHeader:topicModel.profile_image];
    
    //人物认证
    self.certificationImage.frame = CGRectMake(30, 30, 20, 20);
    self.certificationImage.hidden = !topicModel.isSina_v;
    
    //用户名
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(8);
        make.top.equalTo(self.mas_top).offset(16);
        
    }];
    self.userNameLabel.text = topicModel.name;
    
    //发帖时间
    [self.timeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(8);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(5);
    }];
    self.timeTextLabel.text = topicModel.passtime;
    
    //反馈按钮
    [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.right.offset(- 10);
        make.size.sizeOffset(CGSizeMake(50, 50));
    }];
    
    //内容
    self._textLabel.syd_x = Margin;
    self._textLabel.syd_y = CGRectGetMaxY(self.headImage.frame) + Margin;
    self._textLabel.syd_width = ScreenW - 2*Margin;
    self._textLabel.syd_height = topicModel.textHeight;
    self._textLabel.text = topicModel.text;
    
    //下面的工具栏
    [self.botttomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.sizeOffset(CGSizeMake(ScreenW, 35));
        make.left.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        
    }];
    
    //四个数据按钮
    [self.btnTitles removeAllObjects];
    [self.btnTitles addObject:@(topicModel.ding)];
    [self.btnTitles addObject:@(topicModel.cai)];
    [self.btnTitles addObject:@(topicModel.repost)];
    [self.btnTitles addObject:@(topicModel.comment)];
   
    //工具栏四个按钮
    CGFloat btnWidth = ScreenW / self.btns.count;
    for (int i = 0; i < self.btns.count; i ++) {
        UIButton *btn = self.btns[i];
        btn.frame = CGRectMake(btnWidth * i, 0, btnWidth, SYDtitlesViewH);
        [self setupButtonTitle:btn number:[self.btnTitles[i] integerValue] placeholder:self.titles[i]];

    }
    
    //中间的内容
    if (topicModel.type == TopicTypePicture) {
        self.pictureView.frame = topicModel.middleFrame;
        self.pictureView.topicModel = topicModel;
    }else if (topicModel.type == TopicTypeVideo){
        self.videoView.frame = topicModel.middleFrame;
        self.videoView.topicModel = topicModel;
    }else if (topicModel.type == TopicTypeVoice){
        self.voiceView.frame = topicModel.middleFrame;
        self.voiceView.topicModel = topicModel;
        
    }else{
    }
    self.pictureView.hidden = !(topicModel.type == TopicTypePicture);
    self.voiceView.hidden = !(topicModel.type == TopicTypeVoice);
    self.videoView.hidden = !(topicModel.type == TopicTypeVideo);
    
}

@end
