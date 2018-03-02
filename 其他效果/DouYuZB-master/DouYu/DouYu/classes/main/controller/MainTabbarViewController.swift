//
//  MainTabbarViewController.swift
//  DouYu
//
//  Created by ADMIN on 16/10/20.
//  Copyright © 2016年 ADMIN. All rights reserved.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(storyName: "Home");
        addChildVC(storyName: "Live");
        addChildVC(storyName: "Me");
        addChildVC(storyName: "Follow");
       
    }

   fileprivate func addChildVC(storyName: String) {
        
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController();
        addChildViewController(childVc!);
        
        
    }

    

}
