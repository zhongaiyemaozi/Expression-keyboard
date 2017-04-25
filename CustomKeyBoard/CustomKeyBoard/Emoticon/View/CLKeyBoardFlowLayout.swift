//
//  CLKeyBoardFlowLayout.swift
//  CustomKeyBoard
//
//  Created by 夜猫子 on 2017/4/25.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

import UIKit

class CLKeyBoardFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        self.itemSize = CGSize(width: screenWidth, height: 150)
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
