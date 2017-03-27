//
//  FirstViewController.swift
//  LyTabBarViewController
//
//  Created by 张杰 on 2017/3/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initData()
    }
    
    fileprivate func initView() {
        initNav()
        view.backgroundColor = UIColor.white
        view.addSubview(item)
        view.addSubview(contentView)
    }
    
    fileprivate func initData() {
        
    }
    
    //初始化导航栏
    fileprivate func initNav() {
        
        navigationItem.title = nil
        
        let left = UIBarButtonItem(imageName: "logo", target: self, action: #selector(leftNavClick))
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = -10
        navigationItem.leftBarButtonItems = [space,left]
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: size , target: self, action: #selector(historyNavClick))
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size , target: self, action: #selector(searchNavClick))
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size , target: self, action: #selector(scanNavClick))
        let item = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        item.width = -10
        navigationItem.rightBarButtonItems = [item , historyItem, searchItem, qrcodeItem]
    }

    @objc fileprivate func leftNavClick() {
        
    }
    
    @objc fileprivate func historyNavClick() {
        
    }
    
    @objc fileprivate func searchNavClick() {
        
    }
    
    @objc fileprivate func scanNavClick() {
        
    }
    
    fileprivate lazy var menuItem : LyMenuItem = {
        let menuItem = LyMenuItem()
        menuItem.arrayTitle = ["推荐", "游戏" , "娱乐" , "趣玩"]
        menuItem.scrollView = self.scrollView
        menuItem.frame = CGRect(x: 0, y: kNavigationBarH + kStatusBarH, width: kScreenW, height: 40)
        return menuItem
    }()
    
    fileprivate lazy var item : LyScrollMenuItem = {[weak self] in
        let item = LyScrollMenuItem(frame: CGRect(x: 0, y: kNavigationBarH + kStatusBarH, width: kScreenW, height: 40), itemArray: ["推荐", "游戏" , "娱乐" , "趣玩"], scrollView: (self?.contentView.collectionView)!)
        item.delegate = self
        return item
    }()
    
    fileprivate lazy var contentView : LyContentTableView = {[weak self] in
        
//        self.view.frame.maxY
//        let y = self?.item.frame.maxY
        let y = kNavigationBarH + kStatusBarH + 40
        
        let contentView = LyContentTableView(frame: CGRect(x: 0, y: y, width: kScreenW, height: kScreenH - y - kTabbarH), childVcs: [OneViewController() , TwoViewController() , ThreeVC() , FourViewController()], parentViewController: self!)
        contentView.delegate = self
        return contentView
    }()
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor.white
        scrollView.frame = CGRect(x: 0, y: kNavigationBarH + kStatusBarH + 40, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationBarH - kTabbarH - 40)
        scrollView.contentSize = CGSize(width: kScreenW * 6, height: 0)
        return scrollView
    }()
}

extension FirstViewController : LyScrollMenuItemDelegate {
    func lyScrollMenuItemTapMenu(index : NSInteger) {
//        scrollView.contentOffset = CGPoint(x: CGFloat(index) * scrollView.frame.size.width, y: 0)
        contentView.changIndex(index : index)
    }
}

extension FirstViewController : LyContentTableViewDelegate {
    func lyContentTableView(_ contentView : LyContentTableView, progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        item.lyMenuItem(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
