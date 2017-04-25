//
//  CLEmotionTool.swift
//  CustomKeyBoard
//
//  Created by 夜猫子 on 2017/4/25.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

import UIKit

class CLEmotionTool: NSObject {
    
    /// 设置单例
    static let shared: CLEmotionTool = CLEmotionTool()
    
    /// 使用这个计算属性便可以拿到所有的表情数组
    //如果还需要只需要加上路径直接调用就好
    var dataSourceArr: [[[CLEmotionModel]]] {
        //1. 得到最近的二维数组
        let recentEmotions = devideEmotions(emotions: parseInfoPlist(path: defaultPath))
        
        //2. 得到默认的二维数组
        let defaultEmotions = devideEmotions(emotions: parseInfoPlist(path: defaultPath))
        
        //3. emoji
        let emojiEmotions = devideEmotions(emotions: parseInfoPlist(path: emojiPath))
        
        //4. lxh
        let lxhEmotions = devideEmotions(emotions: parseInfoPlist(path: lxhPath))
        
        return [recentEmotions, defaultEmotions, emojiEmotions, lxhEmotions]
    }
    
    
    /// 表情包的路径
    var bundlePath: String {
        return Bundle.main.path(forResource: "Emoticons.bundle", ofType: nil)!
    }
    
    /// 默认表情的info.plist的路径
    var defaultPath: String {
        return bundlePath + "/Contents/Resources/default/info.plist"
    }
    
    /// emoji表情的info.plist的路径
    var emojiPath: String {
        return bundlePath + "/Contents/Resources/emoji/info.plist"
    }
    
    /// lxh表情的info.plist的路径
    var lxhPath: String {
        return bundlePath + "/Contents/Resources/lxh/info.plist"
    }
    
    
    /// 从info.plist中解析表情
    func parseInfoPlist(path: String) -> [CLEmotionModel] {
        var emotionModelsArr: [CLEmotionModel] = []
        if let dicArry = NSArray(contentsOfFile: path) as? [[String: Any]] {
            emotionModelsArr = NSArray.yy_modelArray(with: CLEmotionModel.self, json: dicArry) as! [CLEmotionModel]
            
            for model in emotionModelsArr {
                if model.type == 0 {
                    model.fullPngPath = (path as NSString).deletingLastPathComponent + "/" + model.png!
                }
            }
        }
        return emotionModelsArr
    }
    
    /// 生一个section的数据源数组: 将某种表情按照cell进行分组, 20个一组, 如果不足20个,单独分一组
    func devideEmotions(emotions:[CLEmotionModel]) -> [[CLEmotionModel]] {

        let pageCount = (emotions.count - 1)/20 + 1
        var devidedEmotions: [[CLEmotionModel]] = []
        var location = 0
        var length = 20
        for i in 0..<pageCount {
            if emotions.count - i * length < length {
                length = emotions.count - i * length
            }
            let range = NSMakeRange(location, length)

            let emotionsPerCell = (emotions as NSArray).subarray(with: range) as! [CLEmotionModel]

            devidedEmotions.append(emotionsPerCell)
            location += 20
        }
        
        return devidedEmotions
    }

    
}
