//
//  RecommendViewController.swift
//  DouYu
//
//  Created by Kobe24 on 16/10/23.
//  Copyright © 2016年 ADMIN. All rights reserved.
//

import UIKit

private let KItemMargin : CGFloat = 10;

private let itemW = (KScreenW - KItemMargin * 3)/2;

private let itemH = itemW * 3/4;

private let preItemH = itemW * 4/3;

private let NormalCellID = "NormallCellID"

private let HeadViewID = "HeadSectionView";

private let prettyCellID = "prettyCellID";

private let KHeadSectionH: CGFloat = 50;

private let kCycleViewH : CGFloat = KScreenW * 3/8;

class RecommendViewController: UIViewController {
    
    
    fileprivate lazy var recommedVM : RecommendViewModel = RecommendViewModel();
    
    fileprivate lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 0;

        layout.itemSize = CGSize(width: itemW, height: itemH);
        layout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin);
        layout.headerReferenceSize = CGSize(width: KScreenW, height: KHeadSectionH);
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = UIColor.white;
        //根据父控件的大小变化而变化
         collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight];
           collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: NormalCellID);
        collectionView.register(UINib(nibName: "CollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeadViewID);
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: prettyCellID);

        return collectionView;
        
    }()
    
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView();
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: KScreenW, height: kCycleViewH);
        cycleView.backgroundColor = UIColor.yellow;
        return cycleView;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       //请求推荐数据
        recommedVM.requestData{
            self.collectionView.reloadData();
        }
        //请求无限轮播数据
        recommedVM.requestCycleData { 
            self.cycleView.cycleModels = self.recommedVM.cycleModels;
        }
        
        
        view.addSubview(collectionView);
        
        collectionView.addSubview(cycleView);
        //设置collection的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0);

    }

    
}

extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return self.recommedVM.anchorGroups.count;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            let anchorGroup = self.recommedVM.anchorGroups[section]
            return anchorGroup.anchors.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
         let anchor = self.recommedVM.anchorGroups[indexPath.section].anchors[indexPath.item];
        
        if indexPath.section == 1 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: prettyCellID, for: indexPath) as! CollectionViewPrettyCell;
            cell.anchorModel = anchor;
            return cell;
        }else{
            
           let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCellID, for: indexPath) as! CollectionViewNormalCell;
            
            cell.anchorModel = anchor;
         
            return cell;
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeadViewID, for: indexPath) as! CollectionHeadView;
        reView.backgroundColor = UIColor.white;
        reView.anchorGroup = self.recommedVM.anchorGroups[indexPath.section];
        return reView;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let size: CGSize;
        
        if indexPath.section == 1{
            size = CGSize(width: itemW, height: preItemH);
            return size;
        }
        
        size = CGSize(width: itemW, height: itemH);
        
        return size;
        
    }
}
