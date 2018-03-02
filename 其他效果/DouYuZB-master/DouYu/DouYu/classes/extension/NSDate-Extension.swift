//
//  NSDate-Extension.swift
//  DouYu
//
//  Created by ADMIN on 16/11/23.
//  Copyright © 2016年 ADMIN. All rights reserved.
//

import Foundation


extension Date{
    static func getCurrentTime() -> String{
        let date = NSDate()
        let sine = Int(date.timeIntervalSince1970);
        return "\(sine)";
    }
}
