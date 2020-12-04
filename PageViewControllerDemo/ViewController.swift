//
//  ViewController.swift
//  PageViewControllerDemo
//
//  Created by 陳韋全 on 2018/6/11.
//  Copyright © 2018年 陳韋全. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PageViewControllerSegue" {
            guard let pageViewController = segue.destination as? PageViewController else { return }
            pageViewController.pageViewControllerDelegate = self
        }
    }
}

// MARK: PageViewControllerDelegate
extension ViewController: PageViewControllerDelegate {
    
    /// 設定總頁數
    ///
    /// - Parameters:
    ///   - pageViewController: _
    ///   - numberOfPage: _
    func pageViewController(_ pageViewController: PageViewController, didUpdateNumberOfPage numberOfPage: Int) {
        pageControl.numberOfPages = numberOfPage
    }
    
    /// 設定切換至第幾頁
    ///
    /// - Parameters:
    ///   - pageViewController: _
    ///   - pageIndex: _
    func pageViewController(_ pageViewController: PageViewController, didUpdatePageIndex pageIndex: Int) {
        pageControl.currentPage = pageIndex
    }
}

