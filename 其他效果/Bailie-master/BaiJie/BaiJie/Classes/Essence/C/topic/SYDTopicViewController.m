//
//  SYDTopicViewController.m
//  BaiJie
//
//  Created by ADMIN on 17/8/23.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDTopicViewController.h"
#import "SYDTopicModel.h"
#import <MJRefresh/MJRefresh.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "SYDTopicTableViewCell.h"
static NSString * const TopicCellID = @"TopicCellID";

@interface SYDTopicViewController ()
@property (nonatomic, copy) NSString *maxtime;

@property (nonatomic, strong) NSMutableArray <SYDTopicModel *> *topics;
@property (nonatomic, strong) NSMutableDictionary *params;

@property (nonatomic, assign) NSInteger page;

@end

@implementation SYDTopicViewController

-(NSMutableArray<SYDTopicModel *> *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

-(TopicType)type{
    return 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, SYDTabbarH, 0);

    
    [self setupRefresh];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYDTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicCellID];
    if (cell == nil) {
        cell = [[SYDTopicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TopicCellID];
    }
    SYDTopicModel * model = self.topics[indexPath.row];
    cell.topicModel = model;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYDTopicModel * model = self.topics[indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SYDTopicTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
}


- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    //类似静默加载效果
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}


- (void)loadNewTopics{
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    self.params = parameters;
    
    SYDNetworkTools * tools = [SYDNetworkTools sharedTools];
    
    [tools request:GET urlString:CommonURL parameters:parameters finished:^(id responseObject, NSError * error) {
        
        if (error != nil) {
            if (self.params != parameters) return;
            if (error.code != NSURLErrorCancelled) {
                [SVProgressHUD showErrorWithStatus:@"网路繁忙，请稍后再试！"];
            }
            [self.tableView.mj_header endRefreshing];
            return;
        }
        
        WriteToPlist(responseObject[@"list"]);

        if (self.params != parameters) return;
        _maxtime = responseObject[@"info"][@"maxtime"];
        self.topics = [SYDTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        self.page = 0;
        [self.tableView.mj_header endRefreshing];
        
        
        
    }];
    
    
}

//上拉加载更多
- (void)loadMoreTopics{
    
    [self.tableView.mj_header endRefreshing];
    
    self.page++;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"page"] = @(self.page);
    parameters[@"maxtime"] = _maxtime;
    self.params = parameters;
    
    SYDNetworkTools *tools = [SYDNetworkTools sharedTools];
    
    [tools request:GET urlString:CommonURL parameters:parameters finished:^(id responseObject, NSError * error) {
        
        if (error != nil) {
            if (self.params != parameters) return;
            if (error.code != NSURLErrorCancelled) {
                [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
            }
            [self.tableView.mj_footer endRefreshing];
            self.page--;
            return;
        }
        
        if (self.params != parameters) {
            return;
        }
        _maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *moreTopics = [SYDTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
        
    }];
    
}

@end
