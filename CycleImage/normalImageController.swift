//
//  normalImageController.swift
//  CycleImage
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 胡途. All rights reserved.
//

import UIKit

class normalImageController: UIViewController {

    @IBOutlet weak var imageScrollView: UIScrollView!

    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageCycle()
        //单页图片隐藏页码控制器
        self.pageControl.hidesForSinglePage = true
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
            imageView.image = UIImage(named: "00\(index + 1)")
            let imageX = CGFloat(index) * imageWidth;
            imageView.frame = CGRectMake(imageX,imageY,imageWidth,imageHeight)
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
    
    //页码随着图片的滚动而变化
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let page = (Int)(imageScrollView.contentOffset.x / imageScrollView.frame.size.width + 0.5)
        pageControl.currentPage = page
    }
    


}
