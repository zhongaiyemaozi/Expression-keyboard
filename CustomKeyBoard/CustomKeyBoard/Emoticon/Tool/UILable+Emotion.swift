//
//  UILable+Emotion.swift
//  WeiBo
//
//  Created by 夜猫子 on 2017/4/15.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

import UIKit

extension FFLabel {

    convenience init(title: String?,
                     textColor: UIColor = UIColor.darkGray,
                     fontSize: CGFloat = 14,
                     numOfLines: Int = 0,
                     alignment: NSTextAlignment = .left) {
        self.init()
        
        self.text = title
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.numberOfLines = numOfLines
        self.textAlignment = alignment
        
        self.sizeToFit()
    }
}
