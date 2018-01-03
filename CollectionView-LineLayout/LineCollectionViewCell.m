//
//  LineCollectionViewCell.m
//  CollectionView-LineLayout
//
//  Created by Kobe24 on 2018/1/2.
//  Copyright © 2018年 SYD. All rights reserved.
//

#import "LineCollectionViewCell.h"

@implementation LineCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        NSLog(@"=============%@",NSStringFromCGRect(frame));
    }
    return self;
}

@end
