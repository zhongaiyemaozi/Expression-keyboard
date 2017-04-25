//
//  CLCommon.swift
//  CustomKeyBoard
//
//  Created by 夜猫子 on 2017/4/25.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

import UIKit

import YYModel
import SnapKit

//MARK: - bounds类
let screenBounds = UIScreen.main.bounds
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

//点击表情键盘按钮的通知
let emotionButtonClickedNotification = Notification.Name("emotionButtonClickedNotification")
