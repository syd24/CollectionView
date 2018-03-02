//
//  PageContentView.swift
//  DouYu
//
//  Created by Kobe24 on 16/10/23.
//  Copyright © 2016年 ADMIN. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate:class {
    func pageContentView(pageContentView: PageContentView , progress: CGFloat , sourceIndex: Int, targetIndex: Int);
}

private let cellID = "cellID";

class PageContentView: UIView {
    
    weak var delegate:PageContentViewDelegate?;

    fileprivate var isForbidScrollDelegate : Bool = false
    
    fileprivate var startOffsetX : CGFloat = 0;
    
    fileprivate let _controllers  : [UIViewController];
    
    fileprivate let _parentViewController: UIViewController;
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout();
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = (self?.bounds.size)!;
        layout.scrollDirection = .horizontal;
        
        
        let collectionview = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout);
        collectionview.bounces = false;
        collectionview.showsHorizontalScrollIndicator = false;
        collectionview.isPagingEnabled = true;
        collectionview.dataSource = self;
        collectionview.delegate = self;
        collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID);
        return collectionview;
    }()
    
    //初始化方法
    init(frame: CGRect , controllers:[UIViewController] , parentController:UIViewController?) {
        
        self._controllers = controllers;
        self._parentViewController = parentController!;
        super.init(frame: frame);
        
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

   
}


extension PageContentView{
    
    fileprivate func setupUI(){

        addSubview(collectionView);
        collectionView.frame = bounds;
        for vc in _controllers {
        _parentViewController.addChildViewController(vc);
        }
        
    }
    
}

extension PageContentView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _controllers.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath);
        //移除视图
        for view in item.contentView.subviews {
            view.removeFromSuperview();
        }
        
        let chirldVC = _controllers[indexPath.item];
        chirldVC.view.frame = item.contentView.bounds;
        item.contentView.addSubview(chirldVC.view);
        return item;
    }
    
}

extension PageContentView: UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x;
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate { return }
        
        var progress: CGFloat = 0;
        var sourceIndex: Int = 0;
        var targetIndex: Int = 0;
        
        let currentOffsetX = scrollView.contentOffset.x;
        let scrollViewW = scrollView.frame.width;
        
        if currentOffsetX > startOffsetX {//向左
            
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
            
            sourceIndex = Int(currentOffsetX / scrollViewW);
            
            targetIndex = sourceIndex + 1;
            
            if targetIndex >= _controllers.count {
                targetIndex = _controllers.count - 1;
            }
            
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1;
                targetIndex = sourceIndex;
            }
            
            
        }else{
            
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW));
            
            targetIndex = Int(currentOffsetX/scrollViewW);
            
            sourceIndex = targetIndex + 1;
            
            if sourceIndex >= _controllers.count {
                sourceIndex = _controllers.count - 1;
            }
            
            

        }
        
        
        
        delegate?.pageContentView(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex);
        
        
        
    }
}


extension PageContentView{
    func setCurrentIndex(currentIndex : Int) {
         isForbidScrollDelegate = true
        let offX = CGFloat(currentIndex) * collectionView.frame.width;
        collectionView.setContentOffset(CGPoint(x: offX, y: 0), animated: true);
        
    }
}
