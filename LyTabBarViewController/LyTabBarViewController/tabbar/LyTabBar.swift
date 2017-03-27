//
//  LyTabBar.swift
//  LyTabBarViewController
//
//  Created by 张杰 on 2017/3/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

protocol LyTabBarDelegate : NSObjectProtocol {
    func lyTabBarBtnClick(row : NSInteger)
}

class LyTabBar: UIView {

    weak var delegate : LyTabBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:添加按钮
    func addTabBarButtonWithItem(item : UITabBarItem) {
        
        let btn = LyTabBarButton()
        btn.item = item
        
        if array.isEmpty {
            btn.isSelected = true
            selectBtn = btn
        }
        array.append(btn)
        
        btn.tag = array.count
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        
        addSubview(btn)
    }

    //按钮点击
    @objc fileprivate func btnClick(_ btn : LyTabBarButton) {
        
        //1.取消选中按钮选中
        selectBtn?.isSelected = false
        
        //2.设当前按钮为选中按钮
        btn.isSelected = true
        
        //3.设当前按钮为选中按钮
        selectBtn = btn
        
        if delegate != nil {
            delegate?.lyTabBarBtnClick(row: btn.tag - 1)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = frame.size.width / CGFloat(array.count)
        let h = frame.size.height
        
        for (key , btn) in array.enumerated() {
            
            let x = w * CGFloat(key)
            
            btn.frame = CGRect(x: x, y: 0, width: w, height: h)
        }
    }
    
    fileprivate var array =
        [LyTabBarButton]()
    fileprivate var selectBtn : LyTabBarButton?
}
