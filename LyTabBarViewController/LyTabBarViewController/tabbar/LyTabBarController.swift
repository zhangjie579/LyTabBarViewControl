//
//  LyTabBarController.swift
//  LyTabBarViewController
//
//  Created by 张杰 on 2017/3/23.
//  Copyright © 2017年 张杰. All rights reserved.
//  自定义tabbar

import UIKit

class LyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //添加tabBar
        tabBar.addSubview(lyTabBar)
        
        //添加控制器
        addViewController()
    }
    
    //MARK:移除系统自带的tabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for child in self.tabBar.subviews {
            if child.isKind(of: UIControl.self) {
                child.removeFromSuperview()
            }
        }
    }
    
    fileprivate func addViewController() {
        
        setupChildViewController(vc: FirstViewController(), title: "首页", imageName: "btn_home_normal", selectedImageName: "btn_home_selected" , badge: "78")
        setupChildViewController(vc: MainViewController(), title: "主页", imageName: "btn_column_normal", selectedImageName: "btn_column_selected" , badge: "6")
        setupChildViewController(vc: ThreeViewController(), title: "第三", imageName: "btn_live_normal", selectedImageName: "btn_live_selected" , badge: "89")
        setupChildViewController(vc: MyViewController(), title: "我的", imageName: "btn_user_normal", selectedImageName: "btn_user_selected" , badge: "120")
    }
    
    fileprivate func setupChildViewController(vc : UIViewController , title : String , imageName : String , selectedImageName : String , badge : String) {
        
        vc.title = title
        vc.tabBarItem.image = UIImage.init(named: imageName)
        vc.tabBarItem.selectedImage = UIImage.init(named: selectedImageName)
        vc.tabBarItem.badgeValue = badge
        
        let main = LyNavigationController(rootViewController: vc)
        
        addChildViewController(main)
        
        //添加LyTabBar
        lyTabBar.addTabBarButtonWithItem(item: vc.tabBarItem)
    }

    fileprivate lazy var lyTabBar : LyTabBar = {
        let lyTabBar = LyTabBar()
        lyTabBar.delegate = self
        lyTabBar.frame = self.tabBar.bounds
        return lyTabBar
    }()

}

extension LyTabBarController : LyTabBarDelegate {
    func lyTabBarBtnClick(row: NSInteger) {
        self.selectedIndex = row
    }
}
