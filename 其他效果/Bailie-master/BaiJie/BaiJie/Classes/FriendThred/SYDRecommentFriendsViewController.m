//
//  SYDRecommentFriendsViewController.m
//  BaiJie
//
//  Created by ADMIN on 17/8/29.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDRecommentFriendsViewController.h"
#import "SYDCategoryTableViewCell.h"
#import "SYDRecommendedPeopleTableViewCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

#import "SYDRecommendCategoryModel.h"
#import "SYDRecommendUserModel.h"
@interface SYDRecommentFriendsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;


@property (nonatomic, strong) NSArray *categories;
//参数字典
@property (nonatomic, strong) NSMutableDictionary *params;

@end

static CGFloat const leftTableW = 55;
static NSString * const categoryIdentifier = @"categoryIdentifier";
static NSString * const recommendIdentifier = @"recommendIdentifier";

@implementation SYDRecommentFriendsViewController



- (UITableView *)leftTableView{
    if (_leftTableView == nil) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftTableW, ScreenH) style:UITableViewStylePlain];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
         [_leftTableView registerClass:[SYDCategoryTableViewCell class] forCellReuseIdentifier:categoryIdentifier];
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _leftTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    return _leftTableView;
}

- (UITableView *)rightTableView{
    if (_rightTableView == nil) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(leftTableW, 0, ScreenW - leftTableW, ScreenH) style:UITableViewStylePlain];
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
        _rightTableView.tableFooterView = [UIView new];
        [_rightTableView registerClass:[SYDRecommendedPeopleTableViewCell class] forCellReuseIdentifier:recommendIdentifier];
        _rightTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _rightTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _rightTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    [self setupRefresh];
    [self loadCategories];
    
}
//加载类别
- (void)loadCategories{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    SYDNetworkTools *tool = [SYDNetworkTools sharedTools];
    [tool request:GET urlString:@"http://api.budejie.com/api/api_open.php" parameters:params finished:^(id responseObject , NSError * error) {
        if (error != nil) {
            [SVProgressHUD showWithStatus:@"加载推荐信息失败"];
            return ;
        }
        [SVProgressHUD dismiss];
        self.categories = [SYDRecommendCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.leftTableView reloadData];
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.rightTableView.mj_header beginRefreshing];
    }];
}

//设置MJ刷新
- (void)setupRefresh{
    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.rightTableView.mj_header.automaticallyChangeAlpha = YES;
    self.rightTableView.mj_footer.hidden = YES;
}

//加载最新数据
- (void)loadNewUsers{
    [self.rightTableView.mj_footer endRefreshing];
    
    SYDRecommendCategoryModel *model = self.categories[self.leftTableView.indexPathForSelectedRow.row];
    model.currentPage = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(model.id);
    params[@"page"] = @(model.currentPage);
    self.params = params;
    SYDNetworkTools *tools = [SYDNetworkTools sharedTools];
    [tools request:GET urlString:@"http://api.budejie.com/api/api_open.php" parameters:params finished:^(id responseObject, NSError *error) {
        
        if (error != nil) {
            if (self.params != params) return ;
            [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
            [self.rightTableView.mj_header endRefreshing];
            return;
        }
        
        NSArray *users = [SYDRecommendUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [model.users removeAllObjects];
        [model.users addObjectsFromArray:users];
        model.total = [responseObject[@"total"] integerValue];
        if (self.params != params) {
            return;
        }
        [self.rightTableView reloadData];
        [self.rightTableView.mj_header endRefreshing];
        
        [self checkFooterState];
        
    }];
    
}

//加载更多数据
- (void)loadMoreUsers{
    [self.rightTableView.mj_header endRefreshing];
    
    SYDRecommendCategoryModel *categoryModel = self.categories[self.leftTableView.indexPathForSelectedRow.row];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(categoryModel.id);
    params[@"page"] = @(++categoryModel.currentPage);
    self.params = params;
    
    [[SYDNetworkTools sharedTools] request:GET urlString:@"http://api.budejie.com/api/api_open.php" parameters:params finished:^(id responseObject, NSError *error) {
        
        if (error != nil) {
            if (self.params != params) {
                return ;
            }
            categoryModel.currentPage--;
            [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
            [self.rightTableView.mj_footer endRefreshing];
            return;
        }
        NSArray *users = [SYDRecommendUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [categoryModel.users addObjectsFromArray:users];
        if (self.params != params) {
            return;
        }
        [self.rightTableView reloadData];
        [self checkFooterState];
        
    }];
    
    
}


- (void)checkFooterState{
    SYDRecommendCategoryModel * categoryModel = self.categories[self.leftTableView.indexPathForSelectedRow.row];
    self.rightTableView.mj_footer.hidden = (categoryModel.users.count == 0);
    if (categoryModel.users.count == categoryModel.total) {
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.rightTableView.mj_footer endRefreshing];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
     return    self.categories.count;
    }
    [self checkFooterState];
    SYDRecommendCategoryModel * model =  self.categories[self.leftTableView.indexPathForSelectedRow.row];
   return model.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableView) {
        SYDCategoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:categoryIdentifier forIndexPath:indexPath];
        SYDRecommendCategoryModel * categoryModel = self.categories[indexPath.row];
        cell.categoryModel = categoryModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        SYDRecommendedPeopleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:recommendIdentifier forIndexPath:indexPath];
        SYDRecommendCategoryModel * model =  self.categories[self.leftTableView.indexPathForSelectedRow.row];
        cell.userModel = model.users[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableView) {
        [self.rightTableView.mj_footer endRefreshing];
        [self.rightTableView.mj_header endRefreshing];
        
        SYDRecommendCategoryModel *model = self.categories[indexPath.row];
        if (model.users.count > 0) {
            [self.rightTableView reloadData];
        }else{
            [self.rightTableView reloadData];
            [self.rightTableView.mj_header beginRefreshing];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _rightTableView) {
        return 70;
    }
    return 44;
}

@end
