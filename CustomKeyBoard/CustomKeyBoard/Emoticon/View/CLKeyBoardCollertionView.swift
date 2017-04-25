//
//  CLKeyBoardCollertionView.swift
//  CustomKeyBoard
//
//  Created by 夜猫子 on 2017/4/25.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

import UIKit

private let indetifier = "indetifier"

class CLKeyBoardCollertionView: UICollectionView {
    //接收数据
    var toolBarIndex: Int = 0 {
        didSet {
            let indexPath = IndexPath(item: 0, section: toolBarIndex)
            self.scrollToItem(at: indexPath, at: .left, animated: false)
            
            setupPageControl(indexPath: indexPath)
        }
        
    }
    
    /// 数据源数组
    var dataSourceArr = CLEmotionTool.shared.dataSourceArr
    
    //底部的toolBar
    @available(iOS 9.0, *)
    lazy var toolBar: CLKeyBoardToolBar = {
        let toolBar = CLKeyBoardToolBar()
        
        return toolBar
    }()
    
    /// pageControl属性
    var pageControl: CLPageControl?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: CLKeyBoardFlowLayout())

        setupUI()
        
        self.backgroundColor = UIColor(red: 243 / 255.0, green: 243 / 255.0, blue: 243 / 255.0, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 页面设置
extension CLKeyBoardCollertionView {
    
    fileprivate func setupUI() {
        self.dataSource = self as UICollectionViewDataSource
        self.delegate = self
        self.register(CLCustomKeyBoardCell.self, forCellWithReuseIdentifier: indetifier)
        
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        
    }
}


// MARK: - UICollectionViewDataSource数据源方法
extension CLKeyBoardCollertionView: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return dataSourceArr.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSourceArr[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: indetifier, for: indexPath) as! CLCustomKeyBoardCell
        
        cell.emotions = dataSourceArr[indexPath.section][indexPath.item]
        
        return cell
    }
    
    //代理方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let cells = self.visibleCells

        if cells.count > 1 {
            let cell1 = cells[0]
            let cell2 = cells[1]
            let offsetx = scrollView.contentOffset.x
            let origin1 = abs(offsetx - cell1.frame.origin.x)
            let origin2 = abs(offsetx - cell2.frame.origin.x)

            if origin1 < origin2 {
                let indexPath1 = self.indexPath(for: cell1)
                if #available(iOS 9.0, *) {
                    toolBar.selectedIndex = indexPath1!.section
                    setupPageControl(indexPath: indexPath1!)
                } else {
                    // Fallback on earlier versions
                }
                
                
            }else {
                
                let indexPath2 = self.indexPath(for: cell2)
                if #available(iOS 9.0, *) {
                    toolBar.selectedIndex = indexPath2!.section
                    setupPageControl(indexPath: indexPath2!)
                } else {
                    // Fallback on earlier versions
                }
                
            }
        }
    }
}


// MARK: - 其他设置
extension CLKeyBoardCollertionView {
    
    func setupPageControl(indexPath: IndexPath) {
        pageControl?.number = dataSourceArr[indexPath.section].count
        pageControl?.current = indexPath.item
        
    }
    
}
