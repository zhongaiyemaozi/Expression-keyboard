//
//  CLPageControl.swift
//  CustomKeyBoard
//
//  Created by 夜猫子 on 2017/4/25.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

import UIKit

class CLPageControl: UIPageControl {
    
    var current: Int = 0 {
        didSet {
            self.currentPage = current
            
        }
    }
    
    var number: Int = 0 {
        didSet {
            self.numberOfPages = number
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.currentPage = 0
        //取消交互
        self.isEnabled = false
        //默认的小图片
        self.setValue(UIImage(named: "compose_keyboard_dot_normal"), forKey: "_pageImage")
        //选中的小图片
        self.setValue(UIImage(named: "compose_keyboard_dot_selected"), forKey: "_currentPageImage")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
