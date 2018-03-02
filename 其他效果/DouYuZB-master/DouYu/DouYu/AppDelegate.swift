//
//  AppDelegate.swift
//  DouYu
//
//  Created by ADMIN on 16/10/20.
//  Copyright © 2016年 ADMIN. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UITabBar.appearance().tintColor = UIColor.orange;
        
        return true
    }
}

