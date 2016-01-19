//
//  CycleImageController.swift
//  CycleImage
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 胡途. All rights reserved.
//

import UIKit

class CycleImageController: UIViewController,UIScrollViewDelegate {

    var imageScrollView = UIScrollView()
    let pageController = UIPageControl()
    let imageViewCount = 3
    let screenWidth = UIScreen.mainScreen().bounds.width
    let imageScrollViewHeight: CGFloat = 150
    //当前图片
    var centerImageView = UIImageView()
    //左边图片
    var leftImageView = UIImageView()
    //右边图片
    var rightImageView = UIImageView()
    //图片总数
    let imageCount = 6
    //当前图片索引
    var currentImageIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        self.addScrollView()
        self.addImageViews()
        self.addDefaultImage()
        self.addPageControl()
        self.startTimer()
    }
    
    //添加ScrollView
    func addScrollView() {
        //设置ScrollView的frame
        imageScrollView = UIScrollView(frame: CGRect(x: 0, y: 200, width: screenWidth, height: imageScrollViewHeight))
        self.view.addSubview(imageScrollView)
        imageScrollView.backgroundColor = UIColor.redColor()
        imageScrollView.delegate = self
        //设置contentSize
        imageScrollView.contentSize = CGSizeMake(CGFloat(imageViewCount) * screenWidth,150)
        
        imageScrollView.setContentOffset(CGPointMake(screenWidth, 0), animated: true)
        
        //分页
        imageScrollView.pagingEnabled = true
        //去掉滚动条
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.showsVerticalScrollIndicator = false
      
    }
    
    // MARK: 添加imageView
    func addImageViews() {
        leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: imageScrollViewHeight))
        centerImageView = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: screenWidth, height: imageScrollViewHeight))
        rightImageView = UIImageView(frame: CGRect(x: screenWidth * 2, y: 0, width: screenWidth, height: imageScrollViewHeight))
        imageScrollView.addSubview(leftImageView)
        imageScrollView.addSubview(centerImageView)
        imageScrollView.addSubview(rightImageView)
    }
    
    // MARK: 添加默认图片
    func addDefaultImage() {
        //添加默认图片
        leftImageView.image = UIImage(named: "006")
        centerImageView.image = UIImage(named: "001")
        rightImageView.image = UIImage(named: "002")
        
        pageController.currentPage = currentImageIndex
    
    }
    
    // MARK: 添加页码控制器
    func addPageControl() {
        //总页数
        pageController.numberOfPages = imageCount
        
        //根据页数返回UIPageControl合适的大小
        let size = pageController.sizeForNumberOfPages(imageCount)
        pageController.frame = CGRectMake(screenWidth - 100, 320, size.width, size.height)
        self.view.addSubview(pageController)
        
    }
    
    //定时器
    private var timer: NSTimer!
    
    //开启定时器
    func startTimer() {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("refreshImage"), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    
    //停止定时器
    func stopTimer() {
        timer.invalidate()
    }
    
    //停止加速时调用
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

        refreshImage()
        imageScrollView.setContentOffset(CGPointMake(screenWidth, 0), animated: false)
    }
    

    //用户即将开始拖拽scrollView时，停止定时器
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopTimer()
    }
    
    //当用户已经结束拖拽scrollView时，开启定时器
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    
    // MARK: - 刷新图片
    func refreshImage() {
    
        let offset = imageScrollView.contentOffset
        
        if (offset.x >= screenWidth) { //向右滑动
            currentImageIndex = (currentImageIndex+1) % imageCount
        }else { //向左滑动
            currentImageIndex = (currentImageIndex - 1 + imageCount ) % imageCount
        }
        pageController.currentPage = currentImageIndex % imageCount
        centerImageView.image = UIImage(named: "00\(currentImageIndex + 1)")
        //重新设置左右图片
        let leftImageIndex=(currentImageIndex + imageCount - 1) % imageCount
        let rightImageIndex=(currentImageIndex + 1) % imageCount
        leftImageView.image = UIImage(named: "00\(leftImageIndex + 1)")
        rightImageView.image = UIImage(named: "00\(rightImageIndex + 1)")
        

   }
    

}
