//
//  CLCustomKeyBoard.swift
//  CustomKeyBoard
//
//  Created by 夜猫子 on 2017/4/25.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

import UIKit

class CLCustomKeyBoard: UIView {
    
    
    /// 懒加载CollectionView
    lazy var emotionView: CLKeyBoardCollertionView = {
        let emotionView = CLKeyBoardCollertionView()
        
        return emotionView
    }()
    
    var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    /// pageControl懒加载
    lazy var pageControl: CLPageControl = {
        let pageControl = CLPageControl()
        
        return pageControl
    }()
    
    //底部的toolBar
    @available(iOS 9.0, *)
    lazy var toolBar: CLKeyBoardToolBar = {
        
        let toolBar = CLKeyBoardToolBar()
        toolBar.delegate = self
        return toolBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //页面设置
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - 页面设置
extension CLCustomKeyBoard {
    fileprivate func setupUI() {
        //赋值
        pageControl.numberOfPages = self.emotionView.dataSourceArr[0].count
        emotionView.pageControl = pageControl
        
        if #available(iOS 9.0, *) {
            emotionView.toolBar = toolBar
        } else {
            // Fallback on earlier versions
        }
        
        //添加控件
        addSubview(emotionView)
        addSubview(pageControl)
        if #available(iOS 9.0, *) {
            addSubview(toolBar)
        } else {
            // Fallback on earlier versions
        }

        if #available(iOS 9.0, *) {
            toolBar.backgroundColor = UIColor.lightGray
        } else {
            // Fallback on earlier versions
        }
        
        //约束
        emotionView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(150)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.left.right.centerX.equalTo(self)
            make.top.equalTo(emotionView.snp.bottom).offset(10)
            make.height.equalTo(29)
        }
        
        if #available(iOS 9.0, *) {
            toolBar.snp.makeConstraints { (make) in
                make.left.right.bottom.equalTo(self)
                make.height.equalTo(37)
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
}

// MARK: - WBKeyboardToolBarDelegate代理方法
extension CLCustomKeyBoard: CLKeyBoardToolBarDelegate {
    
    func toggleKeyboard(section: Int) {
        emotionView.toolBarIndex = section
        
    }
    
}
