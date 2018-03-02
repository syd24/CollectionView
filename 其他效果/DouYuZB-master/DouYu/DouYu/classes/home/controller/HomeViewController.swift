//
//  HomeViewController.swift
//  DouYu
//
//  Created by Kobe24 on 16/10/23.
//  Copyright © 2016年 ADMIN. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    fileprivate lazy  var pageTitlesView:PageTitleView = {[weak self] in
        
        let frame = CGRect(x: 0, y: KNavigationBarH + KStatusBarH, width: KScreenW, height: 40);
        let titles = ["推荐","游戏","娱乐","趣玩"];
        let pageTitlesView = PageTitleView(frame: frame, titles: titles);
        pageTitlesView.delegate = self;
        return pageTitlesView;
        
    }()
    
    
    
    fileprivate lazy var pageContentView: PageContentView = {[weak self] in
        
        var childVCs = [UIViewController]();
        
        childVCs.append(RecommendViewController());
        childVCs.append(GameViewController());
        childVCs.append(AmuseViewController());
        childVCs.append(FunnyViewController());
       
        
        let frame = CGRect(x: 0, y: KNavigationBarH + KStatusBarH + 40, width: KScreenW, height: KScreenH - KNavigationBarH - KStatusBarH - 40 - 49);
        let pageContentView = PageContentView(frame: frame, controllers: childVCs, parentController: self!);
        pageContentView.delegate = self;
        return pageContentView;
        
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false;
        setUpUI();

    }
    
   
}


extension HomeViewController{
    
    
    fileprivate func setUpUI(){
        //导航栏
        setUpNavigation();
        
        view.addSubview(pageTitlesView);
        
        view.addSubview(pageContentView);
        
    }
    
    fileprivate func setUpNavigation(){
        //设置左边的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo");
        
        
        //设置右边的item
        let  size = CGSize(width: 40, height: 40);
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: size);
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size);
        
        let qrCodeItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size);
        
        navigationItem.rightBarButtonItems = [searchItem,qrCodeItem,historyItem];
        
    }
    
    
}

// PageTitleViewDelegate
extension HomeViewController: PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex: Int) {
        pageContentView.setCurrentIndex(currentIndex: selectedIndex);
    }
}

// PageContentViewDelegate
extension HomeViewController: PageContentViewDelegate{
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitlesView.pagetitleViewWith(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex);
    }
}


