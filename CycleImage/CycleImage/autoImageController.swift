//
//  CycleImage
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 胡途. All rights reserved.
//

import UIKit

class autoImageController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageCycle()
        //单页图片隐藏页码控制器
        self.pageControl.hidesForSinglePage = true
        self.startTimer()
        
    }

    func imageCycle() {
        
        //因为scrollview为导航控制器的第一个加载的，所以要设置一下代码，以免发生64偏移
        automaticallyAdjustsScrollViewInsets = false
        //设置图片宽高，x,y值
        let imageWidth = imageScrollView.frame.size.width
        let imageHeight = imageScrollView.frame.size.height
        let imageY:CGFloat = 0
        let imageTotal = 6
        for index in 0..<imageTotal {
            let imageView = UIImageView()
            let imageX = CGFloat(index) * imageWidth;
            imageView.frame = CGRectMake(imageX,imageY,imageWidth,imageHeight)
            imageView.image = UIImage(named: "00\(index + 1)")
            //添加图片到scrollView上
            imageScrollView.addSubview(imageView)
        }
        //设置scrollView的contentSize
        let contentWidth: CGFloat = imageWidth * CGFloat(imageTotal)
        imageScrollView.contentSize = CGSizeMake(contentWidth, 0)
        //设置分页
        imageScrollView.pagingEnabled = true
        //滚动条隐藏
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.showsVerticalScrollIndicator = false
        //设置总页数
        pageControl.numberOfPages = imageTotal
        
    }
    
    //定时器
    private var timer: NSTimer!
    
    //开启定时器
    func startTimer() {
    
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("nextPage"), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    //停止定时器
    func stopTimer() {
        timer.invalidate()
    }
    
    
    //页码随着图片的滚动而变化
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let page = (Int)(imageScrollView.contentOffset.x / imageScrollView.frame.size.width + 0.5)
        pageControl.currentPage = page
    }
    
    //用户即将开始拖拽scrollView时，停止定时器
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopTimer()
    }
    
    //当用户已经结束拖拽scrollView时，开启定时器
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    //显示下一页
    func nextPage() {
        var page = self.pageControl.currentPage + 1
        if (page == 6)
        {
            page = 0
        }
        
        //scrollView滚动到下一页
        let offset: CGPoint = CGPointMake(CGFloat(page) * imageScrollView.frame.size.width,0)
        imageScrollView.setContentOffset(offset, animated: true)


    }
    


}
