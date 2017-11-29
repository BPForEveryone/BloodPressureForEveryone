//
//  PageViewStaticListController.swift
//  BPApp
//
//  Created by MiningMarsh on 10/8/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation
//
//  BPEPatientDetailPageViewController.swift
//  BPApp
//
//  Created by MiningMarsh on 10/8/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation
import UIKit

class PageViewStaticListController: UIPageViewController {
    
    // Children should override this with the name of the storyboard to get views from.
    func sourceStoryboard() -> String {
        return ""
    }
    
    // Children should override this with a list of views to scroll through, ordered.
    func sourcePageIdentifiers() -> [String] {
        return []
    }
    
    // Lazily created list of view controllers to scroll through.
    private(set) lazy var controllers: [UIViewController] = {
        
        var controllers: [UIViewController] = []
        
        for identifier in self.sourcePageIdentifiers() {
            let controller = UIStoryboard(name: self.sourceStoryboard(), bundle: nil).instantiateViewController(withIdentifier: identifier)
            self.initController(controller: controller)
            controllers.append(controller)
        }
        
        return controllers
    }()
    
    var pageControl = UIPageControl()
    
    // When the view loads, we want to set ourselves as the data source, and setup the first view controller.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl()
        self.pageControl.numberOfPages = self.controllers.count
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
       
        delegate = self
        dataSource = self
        
        if let controller = controllers.first {
            setViewControllers([controller],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    // Called when we switch views, on the new view.
    func newControllerSelected(controller: UIViewController) {}
    
    // Called when a new view is created.
    func initController(controller: UIViewController) {}
    
}

extension PageViewStaticListController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = controllers.index(of: pageContentViewController)!
    }
}

extension PageViewStaticListController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = controllers.index(of: viewController) else {
            return nil
        }
        
        guard index - 1 >= 0 else {
            return nil
        }
        
        guard controllers.count > index - 1 else {
            return nil
        }
        
        self.newControllerSelected(controller: controllers[index - 1])
        
        return controllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.index(of: viewController) else {
            return nil
        }
        
        guard controllers.count > index + 1 else {
            return nil
        }
        
        self.newControllerSelected(controller: controllers[index + 1])
        
        return controllers[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.controllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
