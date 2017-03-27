//
//  LyMenuItem.swift
//  LyTabBarViewController
//
//  Created by 张杰 on 2017/3/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class LyMenuItem: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var scrollView : UIScrollView? {
        didSet {
            scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .old, context: nil)
        }
    }
    
    var arrayTitle : [String]? {
        didSet {
            
            for (index , value) in (arrayTitle?.enumerated())!
            {
                let label = UILabel()
                label.text = value
                label.textAlignment = .center
                if index == 0 {
                    label.textColor = UIColor.orange
                } else {
                    label.textColor = UIColor.lightGray
                }
                addSubview(label)
                arrayLabel.append(label)
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if object as? UIScrollView != scrollView {
            return
        }
        if keyPath != "contentOffset" {
            return
        }
        
        
        let old = change?[.oldKey] as? CGPoint
        let x = (scrollView?.contentOffset.x)! / (scrollView?.frame.size.width)! + 0.5
        let i = Int(x)
        
        for (index , label) in arrayLabel.enumerated() {
            
            if i == index {
                label.textColor = UIColor.orange
            } else {
                label.textColor = UIColor.lightGray
            }
        }
        let a = ((scrollView?.contentOffset.x)! - (old?.x)!) / (scrollView?.frame.size.width)! * frame.size.width / CGFloat(arrayLabel.count)

        //        line.transform = (line.transform).translatedBy(x: x * line.frame.size.width, y: 0)
        var rect = line.frame
        rect.origin.x += a
        line.frame = rect
    }
    
    deinit {
        scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = frame.size.width / CGFloat(arrayLabel.count)
        let h = frame.size.height - kLineH
        
        for (index , label) in arrayLabel.enumerated() {
            
            let x = w * CGFloat(index)
            
            label.frame = CGRect(x: x, y: 0, width: w, height: h)
        }
        
        line.frame = CGRect(x: 0, y: h, width: w, height: kLineH)
    }
    
    fileprivate var arrayLabel = [UILabel]()
    
    fileprivate lazy var line : UIView = {
       
        let line = UIView()
        line.backgroundColor = UIColor.orange
        return line
    }()
}
