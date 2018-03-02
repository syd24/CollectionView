//
//  NetworkTools.swift
//  DouYu
//
//  Created by ADMIN on 16/11/11.
//  Copyright © 2016年 ADMIN. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools: NSObject {
    
    class func  requestData(type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback: @escaping (_ result : Any) -> ()) {
        
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post;
        
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            guard let result = response.result.value else{
                return;
            }
            
            finishedCallback(result)
            
        }
        
        
    }

}
