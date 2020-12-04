//
//  PageViewController.swift
//  PageViewControllerDemo
//
//  Created by 陳韋全 on 2018/6/13.
//  Copyright © 2018年 陳韋全. All rights reserved.
//

import UIKit

protocol PageViewControllerDelegate: class {
    
    /// 設定頁數
    ///
    /// - Parameters:
    ///   - pageViewController: _
    ///   - numberOfPage: _
    func pageViewController(_ pageViewController: PageViewController, didUpdateNumberOfPage numberOfPage: Int)
    
    /// 當 pageViewController 切換頁數時，設定 pageControl 的頁數
    ///
    /// - Parameters:
    ///   - pageViewController: _
    ///   - pageIndex: _
    func pageViewController(_ pageViewController: PageViewController, didUpdatePageIndex pageIndex: Int)
}

class PageViewController: UIPageViewController {
    
    var viewControllerList: [UIViewController] = [UIViewController]()
    weak var pageViewControllerDelegate: PageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        dataSource = self
        
        // 依 storyboard ID 生成 viewController 並加到要用來顯示 pageViewController 畫面的陣列裡
        viewControllerList.append(getViewController(withStoryboardID: "FirstPageViewController"))
        viewControllerList.append(getViewController(withStoryboardID: "SecondPageViewController"))
        viewControllerList.append(getViewController(withStoryboardID: "ThirdPageViewController"))
                
        // 設定 pageViewControoler 的首頁
        setViewControllers([viewControllerList.first!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        // 設定 pageControl 的總頁數
        pageViewControllerDelegate?.pageViewController(self, didUpdateNumberOfPage: viewControllerList.count)
    }
    
    /// 依 storybyardID 取得 viewController
    ///
    /// - Parameter storyboardID: _
    /// - Returns: _
    fileprivate func getViewController(withStoryboardID storyboardID: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyboardID)
    }
}

// MARK: UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
    
    /// 上一頁
    ///
    /// - Parameters:
    ///   - pageViewController: _
    ///   - viewController: _
    /// - Returns: _
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 取得當前頁數的 index(未翻頁前)
        let currentIndex = viewControllerList.index(of: viewController)!
        
        // 設定上一頁的 index
        let priviousIndex = currentIndex - 1
        
        // 判斷上一頁的 index 是否小於 0，若小於 0 則停留在當前的頁數
        return priviousIndex < 0 ? nil : viewControllerList[priviousIndex]
    }
    
    /// 下一頁
    ///
    /// - Parameters:
    ///   - pageViewController: _
    ///   - viewController: _
    /// - Returns: _
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // 取得當前頁數的 index(未翻頁前)
        let currentIndex = viewControllerList.index(of: viewController)!
        
        // 設定下一頁的 index
        let nextIndex = currentIndex + 1
        
        // 判斷下一頁的 index 是否大於總頁數，若大於則停留在當前的頁數
        return nextIndex > viewControllerList.count - 1 ? nil : viewControllerList[nextIndex]
    }
}

// MARK: UIPageViewControllerDelegate
extension PageViewController: UIPageViewControllerDelegate {
    
    /// 切換完頁數觸發的 func
    ///
    /// - Parameters:
    ///   - pageViewController: _
    ///   - finished: _
    ///   - previousViewControllers: _
    ///   - completed: _
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // 取得當前頁數的 viewController
        let currentViewController = (viewControllers?.first)!
        
        // 取得當前頁數的 index
        let currentIndex = viewControllerList.index(of: currentViewController)!
        
        pageViewControllerDelegate?.pageViewController(self, didUpdatePageIndex: currentIndex)
    }
}
