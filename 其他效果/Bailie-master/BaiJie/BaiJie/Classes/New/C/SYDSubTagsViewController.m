//
//  SYDSubTagsViewController.m
//  BaiJie
//
//  Created by ADMIN on 17/7/31.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

#import "SYDSubTagsViewController.h"
#import "SYDSubTagsModel.h"
#import "SYDSubTagsTableViewCell.h"

static NSString * const ID = @"cellID";

@interface SYDSubTagsViewController ()

@property(nonatomic,strong) NSArray *subTags;

@end

@implementation SYDSubTagsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYDSubTagsTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    self.title = @"推荐标签";
}


- (void)loadData{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    [[SYDNetworkTools sharedTools] request:GET urlString:CommonURL parameters:parameters finished:^(id responseObject, NSError * error) {
        
        if (error != nil) {
            return ;
        }
        _subTags = [SYDSubTagsModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.subTags.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYDSubTagsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.item = self.subTags[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end
