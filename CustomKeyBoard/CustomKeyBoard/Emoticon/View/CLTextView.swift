//
//  CLTextView.swift
//  CustomKeyBoard
//
//  Created by 夜猫子 on 2017/4/25.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

import UIKit

class CLTextView: UITextView {
    
    /// 占位文字
    var palceHoder: String = "请输入文字。。。" {
        didSet {
            plable.text = palceHoder
        }
    }
    
    /// 重写父类的UIFont方法
    override var font: UIFont? {
        didSet {
            plable.font = font
        }
    }
    
    /// 占位符lable懒加载
    fileprivate lazy var plable: UILabel = {
        
        let label = UILabel(title: nil, textColor: UIColor.lightGray, fontSize: 14)
        label.font = self.font
        return label
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        setupUI()
        
        self.font = UIFont.systemFont(ofSize: 14)
        //接收通知
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        
        //监听是否是删除表情还是删除表情
        NotificationCenter.default.addObserver(self, selector: #selector(insertOrDeleteEmotion(notification: )), name: emotionButtonClickedNotification, object: nil)

        self.alwaysBounceVertical = true
        self.keyboardDismissMode = .onDrag
    }
    //移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 事件处理
extension CLTextView {
    @objc fileprivate func textDidChange() {
        plable.isHidden = self.text.characters.count > 0
    }
}


// MARK: - 页面设置
extension CLTextView {
    fileprivate func setupUI() {
        
        addSubview(plable)
        let view = UIView()
        insertSubview(view, at: 0)
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            make.width.height.equalTo(self)
        }
        plable.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.top.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-5)
        }
    }
    
}

// MARK: - 对文本进行设置
extension CLTextView {
    @objc fileprivate func insertOrDeleteEmotion(notification: Notification) {
        
        if let userInfo = notification.userInfo,let action = userInfo["action"] as? Bool {

            if action == false {
                self.deleteBackward()
                
            }else {

                if let emotion = userInfo["emotion"] as? CLEmotionModel {
                    self.insertEmotion(emotion: emotion)
                }
            }
        }
        
    }

    /// 对键盘表情设置
    func insertEmotion(emotion: CLEmotionModel) {
        if emotion.type == 1 {
            let emotion = NSString.emoji(withStringCode: emotion.code!)
            self.insertText(emotion!)
        }else {
            let attachMent = NSTextAttachment()
            attachMent.image = UIImage(named: emotion.fullPngPath!)
            attachMent.bounds = CGRect(x: 0, y: -3, width: self.font!.lineHeight, height: self.font!.lineHeight)
            let attachmentString = NSAttributedString(attachment: attachMent)
            let mattachmentString = NSMutableAttributedString(attributedString: attachmentString)
            mattachmentString.addAttributes([NSFontAttributeName: self.font!], range: NSMakeRange(0, mattachmentString.length))
            let atrributedString = self.attributedText.copy() as! NSAttributedString
            let matrributedString = NSMutableAttributedString(attributedString: atrributedString)
            var range = self.selectedRange
            matrributedString.replaceCharacters(in: range, with: mattachmentString)
            range.location += 1
            range.length = 0
            matrributedString.addAttributes([NSFontAttributeName: self.font!], range: NSMakeRange(0, matrributedString.length))
            self.attributedText = matrributedString
            self.selectedRange = range
        }
        
        // 手动发通知
        let notification = Notification(name: NSNotification.Name.UITextViewTextDidChange)
        NotificationCenter.default.post(notification)
        
        //手动调用代理
        self.delegate?.textViewDidChange!(self)
    }
    
}
