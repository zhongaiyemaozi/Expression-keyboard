//
//  ViewController.swift
//  CustomKeyBoard
//
//  Created by 夜猫子 on 2017/4/25.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /// 记录键盘类型: 0是系统键盘, 1是自定义键盘
    var keyboardType: Int = 0
    
    /// toolBar是否执行动画
    var isAnimatin: Bool = true
    
    /// WBTextView
    lazy var composeTextView: CLTextView = {
        let composeTextView = CLTextView()
        composeTextView.palceHoder = "请输入内容..."
        return composeTextView
    }()
    
    //懒加载创建一个toolBar
    lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        return toolBar
    }()
    
    //自定义键盘
    lazy var customKeyboard: CLCustomKeyBoard = {
        
        let customKeyboard = CLCustomKeyBoard(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        customKeyboard.backgroundColor = UIColor(patternImage: UIImage(named: "emoticon_keyboard_background")!)
        
        return customKeyboard
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //监听键盘frame的变化
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
   
    }
    //移除通知
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
}


// MARK: - 页面设置
extension ViewController {

    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
        setupTextView()
        setupToolBar()
        
    }
    
    /// 设置textView
    fileprivate func setupTextView() {
        
        self.view.addSubview(composeTextView)
        composeTextView.delegate = self
        composeTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.bottom.right.equalTo(self.view)
        }
        
    }
    
    /// 设置toolBar
    fileprivate func setupToolBar() {
        
        self.view.addSubview(toolBar)
        toolBar.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.view)
        }
        let dicArray: [[String: Any]] = [["image":"compose_mentionbutton_background", "selector": #selector(changeKeyBoard)], ["image":"compose_trendbutton_background", "selector": #selector(changeKeyBoard)], ["image":"compose_camerabutton_background", "selector": #selector(changeKeyBoard)], ["image":"compose_emoticonbutton_background", "selector": #selector(changeKeyBoard)], ["image":"compose_keyboardbutton_background", "selector": #selector(changeKeyBoard)]]
        var items: [UIBarButtonItem] = []
        for dict in dicArray {
            let button = UIButton(title: nil, image: dict["image"] as? String, target: self, action: dict["selector"] as? Selector)
            let buttonItem = UIBarButtonItem(customView: button)
            button.sizeToFit()
            let flexButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            items.append(buttonItem)
            items.append(flexButtonItem)
        }
        items.removeLast()
        toolBar.items = items
    }
}

// MARK: - 事件处理
extension ViewController {

    @objc fileprivate func changeKeyBoard() {
        
        isAnimatin = false
        composeTextView.resignFirstResponder()
        isAnimatin = true

        if keyboardType == 0 {
            composeTextView.inputView = self.customKeyboard
            keyboardType = 1
        }else {
            composeTextView.inputView = nil
            keyboardType = 0
        }
        composeTextView.becomeFirstResponder()
        
    }
    
    
    /// 当键盘要发生变化时调用
    @objc fileprivate func keyboardWillChange(notification: Notification) {
        if isAnimatin == true {
            if let userInfo = notification.userInfo,
                let rect = userInfo[UIKeyboardFrameEndUserInfoKey]as? NSValue,
                let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval{

                let endY = rect.cgRectValue.origin.y
                let offset = endY - screenHeight

                toolBar.snp.updateConstraints({ (make) in
                    make.bottom.equalTo(self.view).offset(offset)
                })

                UIView.animate(withDuration: duration, animations: {
                    self.view.layoutIfNeeded()
                })
                
            }
        }
    }
    
}


// MARK: - UITextViewDelegate代理方法
extension ViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
}

