//
//  RecommendCycleView.swift
//  DouYu
//
//  Created by ADMIN on 17/1/11.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

import UIKit

class RecommendCycleView: UIView {
    
    var cycleModels: [CycleModel]?{
        didSet{
            //
            self.cycleCollectionView.reloadData();
            
            pageViewControl.numberOfPages = cycleModels?.count ?? 0;
        }
    }

    @IBOutlet weak var cycleCollectionView: UICollectionView!
    @IBOutlet weak var pageViewControl: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib();
        //设置改控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        cycleCollectionView.backgroundColor = UIColor.red;
        cycleCollectionView.dataSource = self;
        cycleCollectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "KCycleID")
    }
    
    //拿控件的大小
    override func layoutSubviews() {
        super.layoutSubviews();
        //设置collection的layout
        let layout = cycleCollectionView.collectionViewLayout as! UICollectionViewFlowLayout;
        layout.itemSize = cycleCollectionView.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal;
        cycleCollectionView.isPagingEnabled = true;
        
    }
}


extension RecommendCycleView{
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView;
    }
}


extension RecommendCycleView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0;
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = cycleCollectionView.dequeueReusableCell(withReuseIdentifier: "KCycleID", for: indexPath);
        
        let cycleModel = cycleModels?[indexPath.item];
        
        item.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue;
        
        return item;
    }
    
}
