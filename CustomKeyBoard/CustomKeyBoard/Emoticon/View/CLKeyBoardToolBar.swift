//
//  CLKeyBoardToolBar.swift
//  CustomKeyBoard
//
//  Created by 夜猫子 on 2017/4/25.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

import UIKit

fileprivate let baseTag = 88

/// 设置代理
protocol CLKeyBoardToolBarDelegate: NSObjectProtocol {
    func toggleKeyboard(section: Int)
    
}


@available(iOS 9.0, *)
class CLKeyBoardToolBar: UIStackView {
    
    //代理属性
    weak var delegate: CLKeyBoardToolBarDelegate?
    
    //记录选中的button
    var selectedButton: UIButton?
    
    /// 计算属性
    var selectedIndex: Int = 0 {
        
        didSet {
            
            let selectedTag = selectedIndex + baseTag
            let button = viewWithTag(selectedTag) as! UIButton
            selectedButton?.isSelected = false
            button.isSelected = true
            selectedButton = button
            
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        axis = .horizontal

        distribution = .fillEqually
        setupUI()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: - 页面设置
@available(iOS 9.0, *)
extension CLKeyBoardToolBar {
    
    fileprivate func setupUI() {
        
        let buttonDicArr:[[String: Any]] = [["title": "最近", "image": "left"],
                                            ["title": "默认", "image": "mid"],
                                            ["title": "emoji", "image": "mid"],
                                            ["title": "浪小花", "image": "right"]]
        
        for (index, dic) in buttonDicArr.enumerated() {
            
            let title = dic["title"] as! String
            let imageName = dic["image"] as! String
            let normalImageName = "compose_emotion_table_\(imageName)_normal"
            let selectedImage = UIImage(named: "compose_emotion_table_\(imageName)_selected")
            let button = UIButton(title: title, titleColor: UIColor.white, fontSize: 16, backImage: normalImageName, target: self, action: #selector(toggleKeyobard(button:)))
            button.setTitleColor(UIColor.darkGray, for: .selected)
            button.setBackgroundImage(selectedImage, for: .selected)
            button.tag = index + baseTag
            addArrangedSubview(button)
            
            if index == 0 {
                button.isSelected = true
                selectedButton = button
                
            }
        }
    }
}



// MARK: - 事件处理
@available(iOS 9.0, *)
extension CLKeyBoardToolBar {

    @objc func toggleKeyobard(button: UIButton) {
        
        selectedButton?.isSelected = false
        button.isSelected = true
        selectedButton = button
        
        delegate?.toggleKeyboard(section: button.tag - baseTag)
    }
}
