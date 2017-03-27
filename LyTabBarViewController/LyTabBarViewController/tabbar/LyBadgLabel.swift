//
//  LyBadgLabel.swift
//  LyTabBarViewController
//
//  Created by 张杰 on 2017/3/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class LyBadgLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.red
        textColor = UIColor.white
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 11)
        layer.cornerRadius = 9
        layer.masksToBounds = true
    }
    
    var badgeValue : String? {
        didSet {
            
            if badgeValue == "" || badgeValue == nil || badgeValue == "0" {
                bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
                return
            }
            else if Int(badgeValue!)! <= 99 {
                text = badgeValue
            }
            else {
                text = "99+"
            }
            var w = sizeWithString(string: text!, maxSize: CGSize(width: 30, height: 18), font: font).width + 2
            w = w >= 18 ? w : 18
            bounds = CGRect(origin: .zero, size: CGSize(width: w, height: 18))
        }
    }
    
    private func sizeWithString(string : String , maxSize : CGSize , font : UIFont) -> CGSize {
        var size = string.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil).size
        let width = ceilf(Float(size.width))
        size.width = CGFloat(Float(width))
        return size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
