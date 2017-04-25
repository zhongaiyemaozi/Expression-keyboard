//
//  CLCustomKeyBoardCell.swift
//  CustomKeyBoard
//
//  Created by 夜猫子 on 2017/4/25.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

import UIKit

fileprivate let baseTag = 888

class CLCustomKeyBoardCell: UICollectionViewCell {
    
    var emotions: [CLEmotionModel]? {
        
        didSet {
            
            if let emotions = emotions {
                for i in 0..<20 {
                    let button = self.viewWithTag(i + baseTag)
                    button?.isHidden = true
                }
                for (i,emotinModel) in emotions.enumerated() {
                    let button = self.viewWithTag(i + baseTag) as! UIButton
                    button.isHidden = false
                    if let imageName = emotinModel.fullPngPath {
                        let image = UIImage(named: imageName)
                        button.setImage(image, for: .normal)
                        button.setImage(image, for: .highlighted)
                        button.setTitle(nil, for: .normal)
                        button.setTitle(nil, for: .highlighted)
                        
                    }else {
                        let emoji = NSString.emoji(withStringCode: emotinModel.code!)
                        button.setImage(nil, for: .normal)
                        button.setImage(nil, for: .highlighted)
                        button.setTitle(emoji, for: .normal)
                        button.setTitle(emoji, for: .highlighted)
                    }
                    
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.contentView.backgroundColor = UIColor(red: 243 / 255.0, green: 243 / 255.0, blue: 243 / 255.0, alpha: 1.0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - 事件处理
extension CLCustomKeyBoardCell {

    @objc fileprivate func emotionClicked(button: UIButton) {
        
        let tag = button.tag - baseTag
        var isInser = true
        if tag == 20 {
            isInser = false
            let userInfo: [String: Any] = ["action": isInser]
            let notification = Notification(name: emotionButtonClickedNotification, object: nil, userInfo: userInfo)
            NotificationCenter.default.post(notification)
            
        }else {
            let emotionModel = emotions?[tag]
            let userInfo: [String: Any] = ["emotion": emotionModel!, "action": isInser]
            let notification = Notification(name: emotionButtonClickedNotification, object: nil, userInfo: userInfo)
            NotificationCenter.default.post(notification)
            
        }
        
    }
}


// MARK: - 页面设置
extension CLCustomKeyBoardCell {
    
    fileprivate func setupUI() {

        let bottomWH = screenWidth / 7
        let firstRect = CGRect(x: 0, y: 0, width: bottomWH, height: bottomWH)
        
        for i in 0..<21 {
            var image: String?
            if i == 20 {
                image = "compose_emotion_delete"
            }
            
            let button = UIButton(title: nil, fontSize: 34, image: image, target: self, action: #selector(emotionClicked(button:)))
            button.tag = i + baseTag
            let row = i / 7
            let col = i % 7
            
            let frame = firstRect.offsetBy(dx: CGFloat(col) * bottomWH, dy: CGFloat(row) * bottomWH)
            
            button.frame = frame
            
            self.contentView.addSubview(button)
            
        }
    }
    
}

