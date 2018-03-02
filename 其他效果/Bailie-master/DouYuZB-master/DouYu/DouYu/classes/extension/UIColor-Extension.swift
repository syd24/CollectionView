//
//  UIColor-Extension.swift
//  DouYu
//
//  Created by Kobe24 on 16/10/23.
//  Copyright © 2016年 ADMIN. All rights reserved.
//

import UIKit

 extension UIColor{
    convenience init(r : CGFloat , g : CGFloat , b : CGFloat) {
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1);
    }
}
