//
//  PageTitleView.swift
//  DouYu
//
//  Created by Kobe24 on 16/10/23.
//  Copyright © 2016年 ADMIN. All rights reserved.
//

import UIKit


protocol PageTitleViewDelegate:class {
    func pageTitleView(titleView: PageTitleView , selectedIndex : Int);
}

private let  KNormalColor: (CGFloat , CGFloat ,CGFloat) = (85,85,85);

private let  KSelectColor: (CGFloat , CGFloat ,CGFloat) = (255,128,0);


private let KScrollViewLineH : CGFloat = 2;


class PageTitleView: UIView {
    
    
    weak var delegate: PageTitleViewDelegate?
    
    fileprivate var currentIndex: Int = 0;

    fileprivate var titles : [String];
    
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.bounces = false;
        scrollView.scrollsToTop = false;
        return scrollView;
        
    }()
    
    fileprivate lazy var scrollViewLine: UIView = {
       let scrollViewLine = UIView()
        scrollViewLine.backgroundColor = UIColor.orange;
        return scrollViewLine;
    }()
    
    init(frame: CGRect , titles: [String]) {
        
        self.titles = titles;
        super.init(frame: frame);
        
        //
        setUpUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}



extension PageTitleView{
    
   fileprivate func setUpUI() {
        
        addSubview(scrollView);
        scrollView.frame = bounds;
        
        //
        setupTitlesLabel();
        //
        setupScrollViewLine();
        
    }
    
    
    
    fileprivate func setupTitlesLabel(){
        
        let labelY : CGFloat = 0;
        let labelW = frame.width/4;
        let labelH = frame.height - KScrollViewLineH;
        
        for (index, title) in titles.enumerated() {
            
            let label = UILabel()
            label.text = title;
            label.tag = index;
            label.font = UIFont.systemFont(ofSize: 16);
            label.textAlignment = .center
          
            let labelX : CGFloat = labelW * CGFloat(index);
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH);
             label.textColor = UIColor.init(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2);
            scrollView.addSubview(label);
            titleLabels.append(label);
            
            //为label 添加手势
            label.isUserInteractionEnabled = true;
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(labelClick));
            label.addGestureRecognizer(tapGes);
            
        }
    }
    
    fileprivate func setupScrollViewLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray;
        let bottomLineH: CGFloat = 0.5;
        bottomLine.frame = CGRect(x: 0, y: frame.height - bottomLineH, width: KScreenH, height: bottomLineH);
        scrollView.addSubview(bottomLine);
        
        
        guard let firstLabel = titleLabels.first else {
            return;
        }
        
        firstLabel.textColor = UIColor.init(r: KSelectColor.0, g: KSelectColor.1, b: KSelectColor.2);
        
        scrollViewLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - KScrollViewLineH, width: firstLabel.frame.width, height: KScrollViewLineH);
        scrollView.addSubview(scrollViewLine);
        
    }
   
    
}


extension PageTitleView{
    
    @objc fileprivate func labelClick(tapGes: UITapGestureRecognizer){
        
        guard let currentLabel = tapGes.view as? UILabel else {return;}
        
        //
        if currentLabel.tag == currentIndex { return;}
        
        let oldLabel = titleLabels[currentIndex];
        
        currentLabel.textColor = UIColor.init(r: KSelectColor.0, g: KSelectColor.1, b: KSelectColor.2);
        
        oldLabel.textColor = UIColor.init(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2);
        
        currentIndex = currentLabel.tag;
        
        let scrollViewLineX = CGFloat(currentIndex) * oldLabel.frame.width;
        
        UIView.animate(withDuration: 0.15) { 
            self.scrollViewLine.frame.origin.x = scrollViewLineX;
        }
        
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex);
    }
    
}

extension PageTitleView{
    
    func pagetitleViewWith(progress: CGFloat , sourceIndex: Int ,targetIndex: Int ) {
        
        //
        let sourceLabel = titleLabels[sourceIndex];
        let targetLabel = titleLabels[targetIndex];
        
        let moveTotal = targetLabel.frame.origin.x - sourceLabel.frame.origin.x;
        let moveX = moveTotal * progress;
        
        scrollViewLine.frame.origin.x = sourceLabel.frame.origin.x + moveX;
        
        
        //
        let colorDelta = (KSelectColor.0 - KNormalColor.0,KSelectColor.1 - KNormalColor.1, KSelectColor.2 - KNormalColor.2);
        
        sourceLabel.textColor = UIColor(r: KSelectColor.0 - colorDelta.0 * progress, g: KSelectColor.1 - colorDelta.1 * progress, b: KSelectColor.2 - colorDelta.2 * progress);
        
        targetLabel.textColor = UIColor(r: KNormalColor.0 + colorDelta.0 * progress, g: KNormalColor.1 + colorDelta.1 * progress, b: KNormalColor.2 + colorDelta.2 * progress);
        
        
        //
        currentIndex = targetIndex;
        
        
    }
    
}
