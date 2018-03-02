//
//  CycleModel.swift
//  DouYu
//
//  Created by Kobe24 on 17/5/17.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    
    var title: String = "";
    var pic_url: String = "";
    
    //房间数据
    var room: [String : NSObject]?{
        didSet{
            guard let _room = room else {return;}
            anchor = AnchorModel(dic: _room);
        }
    }
    
    var anchor: AnchorModel?
    
    //自定义构造函数
    init(dic: [String : NSObject]) {
        super.init();
        setValuesForKeys(dic);
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    

}
