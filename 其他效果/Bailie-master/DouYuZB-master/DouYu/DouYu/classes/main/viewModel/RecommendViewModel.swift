//
//  RecommendViewModel.swift
//  DouYu
//
//  Created by ADMIN on 16/11/23.
//  Copyright © 2016年 ADMIN. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {

    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]();
    
    lazy var cycleModels: [CycleModel] = [CycleModel]()
    
    fileprivate lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    
    fileprivate lazy var prettyGroup: AnchorGroup = AnchorGroup()
    
}

 extension RecommendViewModel{
    
    //请求推荐数据
    func requestData(_ finishCallback: @escaping () -> ())  {
        let dGruop = DispatchGroup()
        dGruop.enter();
        //热门
        NetworkTools.requestData(type: .get, URLString:  "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time": Date.getCurrentTime()]) { (result) in
            guard let resultDict = result as? [String : AnyObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : AnyObject]] else{return}
            self.bigDataGroup.tag_name = "热门";
            self.bigDataGroup.icon_name = "home_header_hot";
            
            for dic in dataArray{
                let anchor = AnchorModel(dic: dic);
                self.bigDataGroup.anchors.append(anchor);
            }
            
            dGruop.leave();
        }
        
        //颜值
          dGruop.enter()
        NetworkTools.requestData(type: .get, URLString:  "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]) { (result) in
            
            guard let resultDict = result as? [String : AnyObject] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String : AnyObject]] else{return}
            
            self.prettyGroup.tag_name = "颜值";
            self.prettyGroup.icon_name = "home_header_phone";
            
            for dic in dataArray{
                let anchor = AnchorModel(dic: dic);
                self.prettyGroup.anchors.append(anchor);
            }

            dGruop.leave();
            
        }
        
        
        
        //
          dGruop.enter()
        NetworkTools.requestData(type: .get, URLString:  "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:  ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]) { (result) in
            
            guard let rseultDict = result as? [String : NSObject] else {return};
            
            guard let dataArray = rseultDict["data"] as? [[String : Any]] else {return};
            
            
            for dic in dataArray{
                self.anchorGroups.append(AnchorGroup(dic: dic));
            }
            dGruop.leave();
        }
    
        dGruop.notify(queue: DispatchQueue.main){
            self.anchorGroups.insert(self.prettyGroup, at: 0);
            self.anchorGroups.insert(self.bigDataGroup, at: 0);
            
            finishCallback();
        }
  }
   //请求无限轮播数据
    func requestCycleData(finishCallback: @escaping () -> ()){
        NetworkTools.requestData(type: .get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version": "2.300"]) { (result) in
            
            print(result);
            guard  let resultDict = result as? [String : NSObject] else {return;}
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return};
            
            for dic in dataArray{
                self.cycleModels.append(CycleModel(dic: dic));
            }
            
            finishCallback();
            
            
        }
        
    }
    


}
