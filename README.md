# LuCycleView
无线轮播

 使用 collectionview  实现 无限轮播
        
         1，添加数据以后  scrollToItem  默认滚动到 80 位置，如果向右滑动 要80次 才划不动
         
         2，numberOfItemsInSection 返回 data.count * 10000;  通过 collectionviewcell 重用机制 每次从重用池里面找 cell
         
         3, 添加定时器 每 3 秒 滚动  一个页面宽度
         
         4, 添加代理回调 点击事件
         
         
          ![image](https://github.com/luzhilei/LuWaveView/blob/master/LuWaveView/Assets.xcassets/wave.imageset/wave.png)

         
