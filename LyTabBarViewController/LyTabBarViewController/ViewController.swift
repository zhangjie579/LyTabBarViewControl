//
//  ViewController.swift
//  LyTabBarViewController
//
//  Created by 张杰 on 2017/3/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
        
        self.view.addObserver(self, forKeyPath: "backgroundColor", options: .new, context: nil)
        
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let value = change?[.newKey] as? UIColor
        print(value)
    }
    
    deinit {
        view.removeObserver(self, forKeyPath: "backgroundColor")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.backgroundColor = UIColor.lightGray
    }
}

