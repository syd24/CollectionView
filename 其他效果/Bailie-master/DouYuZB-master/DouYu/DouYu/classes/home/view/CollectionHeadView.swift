//
//  CollectionHeadView.swift
//  DouYu
//
//  Created by Kobe24 on 16/10/28.
//  Copyright © 2016年 ADMIN. All rights reserved.
//

import UIKit

class CollectionHeadView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headImage: UIImageView!
    
    var anchorGroup : AnchorGroup?{
        didSet{
            titleLabel.text = anchorGroup?.tag_name;
            headImage.image = UIImage(named: (anchorGroup?.icon_name)!);
        }
    }
    
    
    
}
