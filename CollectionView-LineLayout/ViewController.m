//
//  ViewController.m
//  CollectionView-LineLayout
//
//  Created by Kobe24 on 2018/1/2.
//  Copyright © 2018年 SYD. All rights reserved.
//

#import "ViewController.h"
#import "LineLayout.h"
#import "LineCollectionViewCell.h"

#define W [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *lineCollectionView;

@end

@implementation ViewController

- (UICollectionView *)lineCollectionView{
    if (_lineCollectionView == nil) {
        LineLayout *layout = [[LineLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(75, W/2 - 150/2, 75, W/2 - 150/2);
        _lineCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, W, 300) collectionViewLayout:layout];
        _lineCollectionView.dataSource = self;
        [_lineCollectionView registerClass:[LineCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    }
    return _lineCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.lineCollectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    return cell;
}


@end
