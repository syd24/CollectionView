//
//  CollectionViewNormalCell.swift
//  DouYu
//
//  Created by Kobe24 on 16/10/28.
//  Copyright © 2016年 ADMIN. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewNormalCell: UICollectionViewCell {
    @IBOutlet weak var liveNum: UIButton!

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchorModel: AnchorModel? {
        didSet{
            guard let anchor = anchorModel else {return;}
            var onlineNum : String = "";
            if anchor.online >= 10000 {
                onlineNum = "\(Int(anchor.online / 10000))万在线"
                
            }else{
                onlineNum = "\(anchor.online)在线";
            }
            liveNum.setTitle(onlineNum, for: .normal);
            titleLabel.text = anchor.room_name;
            nickNameLabel.text = anchor.nickname;
            
            let url = NSURL(string: anchor.vertical_src)
            
            let source = ImageResource(downloadURL: url as! URL);
            
            
            bgImage.kf_setImage(with: source);
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
