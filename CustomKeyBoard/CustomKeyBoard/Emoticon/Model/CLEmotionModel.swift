//
//  CLEmotionModel.swift
//  CustomKeyBoard
//
//  Created by 夜猫子 on 2017/4/25.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

import UIKit

class CLEmotionModel: NSObject {
    /// 表情的中文文字
    var chs: String?
    
    /// 表情的图片名
    var png: String?
    
    /// 全路径
    var fullPngPath: String?
    
    /// 表情类型，0代表图片表情，1代表emoi表情
    var type: Int = 0
    
    /// emoji表情的16进制字符串
    var code: String?
    
    
    override var description: String {
        return self.yy_modelDescription()
    }

}
