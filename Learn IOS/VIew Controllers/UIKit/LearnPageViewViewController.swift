//
//  LearnPageViewViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/14.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class LearnPageViewViewController: UIPageViewController {

    var viewControllerList: [UIViewController] = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllerList.append(self.getViewController(withStoryboardID: "learnPageViewFirstPage"))
        self.viewControllerList.append(self.getViewController(withStoryboardID: "learnPageViewSecondPage"))
        self.viewControllerList.append(self.getViewController(withStoryboardID: "learnPageViewThirdPage"))
        
        self.dataSource = self
        
        // 設定 pageViewControoler 的首頁
        self.setViewControllers([self.viewControllerList[1]], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func getViewController(withStoryboardID storyboardID: String) -> UIViewController {
        return UIStoryboard(name: "UIKit", bundle: nil).instantiateViewController(withIdentifier: storyboardID)
    }
}

extension LearnPageViewViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 取得當前頁數的 index(未翻頁前)
        let currentIndex: Int =  self.viewControllerList.firstIndex(of: viewController)!
        
        // 設定上一頁的 index
        let priviousIndex: Int = currentIndex - 1
        
        // 判斷上一頁的 index 是否小於 0，若小於 0 則停留在當前的頁數
        return priviousIndex < 0 ? nil : self.viewControllerList[priviousIndex]
    }
   
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // 取得當前頁數的 index(未翻頁前)
        let currentIndex: Int =  self.viewControllerList.firstIndex(of: viewController)!
        
        // 設定下一頁的 index
        let nextIndex: Int = currentIndex + 1
        
        // 判斷下一頁的 index 是否大於總頁數，若大於則停留在當前的頁數
        return nextIndex > self.viewControllerList.count - 1 ? nil : self.viewControllerList[nextIndex]
    }
}
