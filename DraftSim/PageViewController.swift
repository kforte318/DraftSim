//
//  PageViewController.swift
//  DraftSim
//
//  Created by Kevin Forté on 11/11/16.
//  Copyright © 2016 Kevin Forté. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    var packView: UIViewController?
    var deckView: UIViewController?
    var orderedViewControllers: [UIViewController]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        packView = newViewController(id: "packView")
        deckView = newViewController(id: "deckView")
        orderedViewControllers = [packView!, deckView!]
        dataSource = self
        
        if let firstViewController = orderedViewControllers?.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newViewController(id: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: id)
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers?.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers?.last
        }
        
        guard (orderedViewControllers?.count)! > previousIndex else {
            return nil
        }
        
        return orderedViewControllers?[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers?.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers?.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers?.first
        }
        
        guard orderedViewControllersCount! > nextIndex else {
            return nil
        }
        
        return orderedViewControllers?[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return (orderedViewControllers?.count)!
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerindex = orderedViewControllers?.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerindex
    }
}
