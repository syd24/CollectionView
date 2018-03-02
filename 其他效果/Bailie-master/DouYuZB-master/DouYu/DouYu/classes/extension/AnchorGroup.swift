//
//  AnchorGroup.swift
//  DouYu
//
//  Created by ADMIN on 16/11/24.
//  Copyright © 2016年 ADMIN. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    //动态监听数据变化
    var room_list : [[String : NSObject]]?{
        didSet {
            guard let room_list = room_list else {return}
            for dic in room_list {
                anchors.append(AnchorModel(dic: dic));
            }
        }
    }
    
    var tag_name: String = "";
    var icon_name: String = "home_header_normal";
    
    lazy var anchors : [AnchorModel] = [AnchorModel]();
    
   override init() {
    }
    
    init(dic: [String : Any]) {
        super.init()
        setValuesForKeys(dic);
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}
