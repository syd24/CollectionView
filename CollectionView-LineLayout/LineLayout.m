//
//  LineLayout.m
//  CollectionView-LineLayout
//
//  Created by Kobe24 on 2018/1/2.
//  Copyright © 2018年 SYD. All rights reserved.
//

#import "LineLayout.h"

#define ItemSize 150
#define LineSpacing 50
@implementation LineLayout

- (instancetype)init{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(ItemSize, ItemSize);
        self.minimumLineSpacing = LineSpacing;
        self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;//速率
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //水平方向
    }
    return self;
}

//返回滚动停止的点 自动对齐中心
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    CGFloat  offSetAdjustment = MAXFLOAT;
    
    //预期停止水平中心点
    CGFloat horizotalCenter = proposedContentOffset.x + self.collectionView.bounds.size.width / 2;
    
    //预期滚动停止时的屏幕区域
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    //找出最接近中心点的item
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    for (UICollectionViewLayoutAttributes * attributes in array) {
        CGFloat currentCenterX = attributes.center.x;
        if (ABS(currentCenterX - horizotalCenter) < ABS(offSetAdjustment)) {
            offSetAdjustment = currentCenterX - horizotalCenter;
        }
    }
    //
    return CGPointMake(proposedContentOffset.x + offSetAdjustment, proposedContentOffset.y);
}

@end
