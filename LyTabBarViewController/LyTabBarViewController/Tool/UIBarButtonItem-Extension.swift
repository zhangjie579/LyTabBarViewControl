//
//  UIBarButtonItem-Extension.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/3/22.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    
    //便利构造函数 1.convenience 2.在构造函数中必须明确调用一个设计构造函数(self.init...),比如:self.init(customView: btn)
    convenience init(imageName : String , hightImageName : String , size : CGSize , target: Any?, action: Selector) {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.setImage(UIImage.init(named: hightImageName), for: .highlighted)
        btn.frame = CGRect(origin: .zero, size: size)
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
    
    convenience init(imageName : String , target: Any?, action: Selector) {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.sizeToFit()
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
    
    
    class func creatItem(imageName : String , hightImageName : String , size : CGSize) -> UIBarButtonItem {
        
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.setImage(UIImage.init(named: hightImageName), for: .highlighted)
        btn.frame = CGRect(origin: .zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    
}
