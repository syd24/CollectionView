//
//  CollectionViewPrettyCell.swift
//  DouYu
//
//  Created by Kobe24 on 16/10/31.
//  Copyright © 2016年 ADMIN. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewPrettyCell: UICollectionViewCell {

    @IBOutlet weak var city: UIButton!
    @IBOutlet weak var titltNameLabel: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var onLine: UIButton!
    
    var anchorModel: AnchorModel? {
        didSet{
            
             guard let anchor = anchorModel else {return;}
            
            city.setTitle(anchor.anchor_city, for: .normal);
            
            var onlineNum : String = "";
            if (anchorModel?.online)! >= 10000 {
                onlineNum = "\(Int((anchorModel?.online)! / 10000))万在线"
                
            }else{
                onlineNum = "\(anchor.online)在线";
            }
            onLine.setTitle(onlineNum, for: .normal);
            
            let url = NSURL(string: (anchorModel?.vertical_src)!)
            
            let source = ImageResource(downloadURL: url as! URL);
            
            
            bgImage.kf_setImage(with: source);
            
            titltNameLabel.text = anchorModel?.room_name;

        }
    }
    
   
}
