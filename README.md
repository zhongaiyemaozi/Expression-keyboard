#Swift自定义键盘

> 此框架内置了三种表情包，在效果图中可以看到
- 如果你的程序是添加反馈页面，直接把此框架导入即可，调用控制器中的几句代码并可实现
- 如果只是需要键盘，只需要把textView干掉即可，高内聚，低耦合
- 若移植此框架只需要键盘对的情况下需要导入两个第三方库，分别是pod 'YYModel'和pod 'SnapKit'，并且需要一个桥接文件即可

###效果如下


![image](https://github.com/zhongaiyemaozi/Expression-on-the-keyboard/blob/master/%E7%B4%A0%E6%9D%90/1.png)
![image](https://github.com/zhongaiyemaozi/Expression-on-the-keyboard/blob/master/%E7%B4%A0%E6%9D%90/2.png)
![image](https://github.com/zhongaiyemaozi/Expression-on-the-keyboard/blob/master/%E7%B4%A0%E6%9D%90/3.png)


>若你还需要添加自定义表情时，在CLEmotionTool.swift这个类中添加你的表情路径便可
###代码块
``` python
/// lxh表情的info.plist的路径
var lxhPath: String {
return bundlePath + "/Contents/Resources/lxh/info.plist"
}
//4. lxh
let lxhEmotions = devideEmotions(emotions: parseInfoPlist(path: lxhPath))
//把你增加的表情添加到下面的数组中就好
return [recentEmotions, defaultEmotions, emojiEmotions, lxhEmotions]


```


## 反馈与建议
- 微博：[@夜__猫_子](http://weibo.com/u/5022122368)
- 邮箱：<873456034@qq.com>

---------
感谢阅读这份帮助文档。请点击右上角，点赞并分享。



