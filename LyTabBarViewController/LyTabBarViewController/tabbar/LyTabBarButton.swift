//
//  LyTabBarButton.swift
//  LyTabBarViewController
//
//  Created by 张杰 on 2017/3/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class LyTabBarButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(badgeLabel)
        
        setTitleColor(UIColor.lightGray, for: .normal)
        setTitleColor(UIColor.orange, for: .selected)
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
        titleLabel?.textAlignment = .center
        imageView?.contentMode = .center
    }
    
    var item : UITabBarItem?
        {
        didSet {
            item?.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
            item?.addObserver(self, forKeyPath: "badgeValue", options: NSKeyValueObservingOptions.new, context: nil)
            item?.addObserver(self, forKeyPath: "image", options: NSKeyValueObservingOptions.new, context: nil)
            item?.addObserver(self, forKeyPath: "selectedImage", options: NSKeyValueObservingOptions.new, context: nil)
            
            observeValue(forKeyPath: nil, of: nil, change: nil, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        badgeLabel.badgeValue = item?.badgeValue
        
        setTitle(item?.title, for: .normal)
        setTitle(item?.title, for: .selected)
        setImage(item?.image, for: .normal)
        setImage(item?.selectedImage, for: .selected)
        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置提醒数字的位置
        let x = frame.size.width / 2 + 13
        let y = frame.size.height / 2 - 20
        badgeLabel.frame.origin = CGPoint(x: x, y: y)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let h = contentRect.size.height * CGFloat(titleScale)
        let y = contentRect.size.height * CGFloat(1 - titleScale)
        
        return CGRect(x: 0, y: y, width: contentRect.size.width, height: h)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let h = contentRect.size.height * CGFloat(1 - titleScale)
        
        return CGRect(x: 0, y: 0, width: contentRect.size.width, height: h)
    }
    
    deinit {
        item?.removeObserver(self, forKeyPath: "title")
        item?.removeObserver(self, forKeyPath: "badgeValue")
        item?.removeObserver(self, forKeyPath: "image")
        item?.removeObserver(self, forKeyPath: "selectedImage")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate let titleScale = 0.35
    
    private let badgeLabel : LyBadgLabel = {
        let badgeLabel = LyBadgLabel()
        
        return badgeLabel;
    }()
}
