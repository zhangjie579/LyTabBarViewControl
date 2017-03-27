//
//  LyScrollMenuItem.swift
//  LyTabBarViewController
//
//  Created by 张杰 on 2017/3/24.
//  Copyright © 2017年 张杰. All rights reserved.
//  可滑动的菜单menu

import UIKit

//线高度
private let lineH = 2

//文本的宽度，当 > 4个的时候使用 , <=4个的话，就是viewW / count
private let labelW = 100
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

protocol LyScrollMenuItemDelegate : NSObjectProtocol {
    func lyScrollMenuItemTapMenu(index : NSInteger)
}

class LyScrollMenuItem: UIView {

    fileprivate var itemArray : [String]
    fileprivate var scrollView : UIScrollView
    fileprivate var currentIndex : Int
    
    weak var delegate : LyScrollMenuItemDelegate?
    
    init(frame: CGRect , itemArray : [String] , scrollView : UIScrollView) {
        
        self.itemArray = itemArray
        self.scrollView = scrollView
        self.currentIndex = 0
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        //添加子控件
        addLabelAndLine()
        
        addKvo()
    }
    
    fileprivate func addLabelAndLine() {
        
        if itemArray.count > 4 {
            scrollViewMenu.contentSize = CGSize(width: CGFloat(labelW * itemArray.count), height: 0)
        }
        addSubview(scrollViewMenu)
        
        //添加label
        for (index , title) in itemArray.enumerated() {
            let label = UILabel()
            label.text = title
            label.textAlignment = .center
            label.tag = index
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(_:)))
            label.addGestureRecognizer(tap)
            if index == 0 {
                label.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
            } else {
                label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            }
            scrollViewMenu.addSubview(label)
            arrayLabel.append(label)
        }
        
        //添加线
        scrollViewMenu.addSubview(allLine)
        allLine.addSubview(line)
    }
    
    fileprivate func addKvo() {
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: .old, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if object as? UIScrollView != scrollView { return }
        if keyPath != "contentOffset" { return }
        
        let old = change?[.oldKey] as? CGPoint

        let a = (scrollView.contentOffset.x - (old?.x)!) / scrollView.frame.size.width * line.frame.size.width
        
        //修改底部线的位置
        //        line.transform = (line.transform).translatedBy(x: x * line.frame.size.width, y: 0)
        var rect = line.frame
        rect.origin.x += a
        line.frame = rect
        
        //如果 > 4个，让scrollview跟着滑动
        if arrayLabel.count > 4 {
            //最大可滑动位置
            let max = scrollViewMenu.contentSize.width - frame.size.width;
            let centerW = frame.size.width / 2;
            //过了一半
            if line.frame.origin.x > centerW {
                let scl = line.frame.origin.x - centerW >= max ?  max : line.frame.origin.x - centerW
                scrollViewMenu.setContentOffset(CGPoint(x: scl, y: 0), animated: true)
            }
            else {
                scrollViewMenu.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        }
    }
    
    @objc fileprivate func tapClick(_ tap : UITapGestureRecognizer) {
        
        let label = tap.view as? UILabel
        
        if label?.tag == currentIndex { return }
        
        let currentLable = arrayLabel[currentIndex]
        
        currentLable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        label?.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        currentIndex = (label?.tag)!
        
        if delegate != nil {
            delegate?.lyScrollMenuItemTapMenu(index: (label?.tag)!)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollViewMenu.frame = bounds
        
        var w = CGFloat(labelW)
        let h = frame.size.height - CGFloat(lineH)
        
        let allLineW = arrayLabel.count > 4 ? scrollViewMenu.contentSize.width : frame.size.width
        allLine.frame = CGRect(x: 0, y: h, width: allLineW, height: CGFloat(lineH))
        
        if arrayLabel.count <= 4 {
            w = frame.size.width / CGFloat(arrayLabel.count)
        }
        
        line.frame = CGRect(x: 0, y: 0, width: w, height: CGFloat(lineH))
        
        for (index , label) in arrayLabel.enumerated() {
            
            let x = w * CGFloat(index)
            label.frame = CGRect(x: x, y: 0, width: w, height: h)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var arrayLabel = [UILabel]()
    
    fileprivate lazy var line : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.orange
        return line
    }()
    
    fileprivate lazy var allLine : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        return line
    }()
    
    fileprivate lazy var scrollViewMenu : UIScrollView = {
        let scrollViewMenu = UIScrollView()
        scrollViewMenu.showsHorizontalScrollIndicator = false
        scrollViewMenu.scrollsToTop = false
        scrollViewMenu.bounces = false
        return scrollViewMenu
    }()
}

//MARK:外部调用
extension LyScrollMenuItem {
    
    func lyMenuItem(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        // 1.颜色的渐变(复杂)
        let sourceLabel = arrayLabel[sourceIndex]
        let targetLabel = arrayLabel[targetIndex]
        
        // 1.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 1.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 1.3.变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //2.修改当前选中
        currentIndex = targetIndex
    }
}
