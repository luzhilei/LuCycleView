//
//  ViewController.swift
//  LuCycleView
//
//  Created by Rango on 2018/8/15.
//  Copyright © 2018年 Rango. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         使用 collectionview  实现 无限轮播
        
         1，添加数据以后  scrollToItem  默认滚动到 80 位置，如果向右滑动 要80次 才划不动
         2，numberOfItemsInSection 返回 data.count * 10000;  通过 collectionviewcell 重用机制 每次从重用池里面找 cell
         3, 添加定时器 每 3 秒 滚动  一个页面宽度
         4, 添加代理回调 点击事件
         
         */
        
        let cycleView : LuCycleView = {[weak self] in
            let cycleView = LuCycleView.cycleView()
            cycleView.frame = CGRect(x: 0, y: 100, width: (self?.view.bounds.size.width)!, height: 200)
            cycleView.delegate = self
            return cycleView
            }()
        view.addSubview(cycleView)
        let array = NSMutableArray()
        
        for i in 1...4{
            let model = LuCycleModel()
            model.title = "第" + String(i) +  "张"
            model.pic_url =  String(i)
            array.add(model)
        }
       
        cycleView.cycleModels = (array.copy() as! [LuCycleModel])
        
    }

  


}
// MARK:- LuCycleViewDelegate
extension ViewController : LuCycleViewDelegate{
    func didSelectItem(_ cycleView: LuCycleView, selectIndex index: Int) {
        print(index);
    }
}

