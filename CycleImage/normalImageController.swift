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
        self.pageControl.hidesForSinglePage = true
    }

    func imageCycle() {
        
        let imageWidth = imageScrollView.frame.size.width
        let imageHeight = imageScrollView.frame.size.height
        let imageY:CGFloat = 0
        let imageTotal = 6
        for index in 0..<imageTotal {
            let imageView = UIImageView()
            let imageX = CGFloat(index) * imageWidth;
            imageView.frame = CGRectMake(imageX,imageY,imageWidth,imageHeight)
            imageView.image = UIImage(named: "00\(index + 1)")
            imageScrollView.addSubview(imageView)
        }
        let contentWidth: CGFloat = imageWidth * CGFloat(imageTotal)
        imageScrollView.contentSize = CGSizeMake(contentWidth, 0)
        imageScrollView.pagingEnabled = true
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.showsVerticalScrollIndicator = false
        pageControl.numberOfPages = imageTotal
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let page = (Int)(imageScrollView.contentOffset.x / imageScrollView.frame.size.width + 0.5)
        pageControl.currentPage = page
    }
    
    //    func nextPage() {
    //        var page = self.pageControl.currentPage + 1
    //        if (page == 5)
    //        {
    //            page = 0
    //        }
    //
    //        let offset: CGPoint = CGPointMake(CGFloat(page) * imageScrollView.frame.size.width,0)
    //        imageScrollView.setContentOffset(offset, animated: true)
    //        
    //        
    //    }


}
