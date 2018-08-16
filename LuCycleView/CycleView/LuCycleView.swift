//
//  LuCycleView.swift
//  LuCycleView
//
//  Created by Rango on 2018/8/15.
//  Copyright © 2018年 Rango. All rights reserved.
//

import UIKit
protocol LuCycleViewDelegate {
    func didSelectItem(_ cycleView : LuCycleView, selectIndex index : Int)
}

class LuCycleView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cycleTimer : Timer?
    var delegate : LuCycleViewDelegate?
    var cycleModels :[LuCycleModel]? {
        didSet{
            collectionView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 20, section: 0)
            // 默认在 80 位置，如果向右滑动 要80次 才划不动
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            }
             // 定时器 先移除 在添加
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        collectionView.register(UINib(nibName: "LuCycleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        //每次滑动停留在边界
        collectionView.isPagingEnabled = true;

       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        //水平滑动
        layout.scrollDirection = .horizontal;
        // 间距 为 0
        layout.minimumLineSpacing = 0;
    }
    
   

}
extension LuCycleView {
    class func cycleView() -> LuCycleView {
        return Bundle.main.loadNibNamed("LuCycleView", owner: nil, options: nil)?.first as! LuCycleView
    }
}


// MARK:- UICollectionViewDataSource
extension LuCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LuCycleCollectionViewCell
        
        cell.cycleModel = cycleModels![(indexPath as NSIndexPath).item % cycleModels!.count]
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
        let index = (indexPath as NSIndexPath).item % cycleModels!.count + 1
        
        delegate?.didSelectItem(self, selectIndex: index)
    }
}
// MARK:- UICollectionViewDelegate
extension LuCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
      
        addCycleTimer()
    }
}
extension LuCycleView{
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    @objc fileprivate func scrollToNext() {
        // 当前偏移量 + 1个宽度
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
