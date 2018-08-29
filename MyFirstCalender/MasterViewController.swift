//
//  MasterViewController.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 24/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var sideBarVC: SideBarViewController?
    var navVC = UINavigationController()
    var contentVC: UIViewController?
    
    var sideBarState: Bool = false
    
    let SIDEBAR_SLIDING_TIME = 0.3
    let SIDEBAR_WIDTH: CGFloat = 260
    
    override func viewDidLoad() {
        setup()
//        getSideBar()
    }
    
    func setup() {
//        getSideBar()
        
        self.addChild(navVC)
        self.view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        
        let firstVC = MonthViewController()
        navVC.viewControllers.append(firstVC)
//        firstVC.delegate = self
        
        contentVC = firstVC
        
        addSideBarButton()
    }
    
    func getSideBar() {
        let sideVC = SideBarViewController()
        
        self.addChild(sideVC)
        self.view.addSubview(sideVC.view)
        sideVC.didMove(toParent: self)
        
        sideVC.view.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.frame.height)
        
        self.sideBarVC = sideVC
//        self.view.bringSubviewToFront((contentVC?.view)!)
        self.sideBarVC?.delegate = self
    }
    
    func openSideBar(completion: (() -> Void)?) {
        self.getSideBar()
        
        let slidingOptions = UIView.AnimationOptions.curveEaseInOut

        UIView.animate(withDuration: SIDEBAR_SLIDING_TIME, delay: 0, options: slidingOptions,
                       animations: {
                        self.contentVC?.view.frame.origin.x = self.SIDEBAR_WIDTH
                        self.navVC.navigationBar.frame.origin.x = self.SIDEBAR_WIDTH
                        self.sideBarVC?.view.frame.size.width = self.SIDEBAR_WIDTH
        }) { (_) in
            self.sideBarState = true
            completion?()
        }
        
//        let sliding = UIViewPropertyAnimator(duration: SIDEBAR_SLIDING_TIME, curve: .easeInOut) {
//            self.contentVC?.view.frame.origin.x = self.SIDEBAR_WIDTH
//            self.navVC.navigationBar.frame.origin.x = self.SIDEBAR_WIDTH
//            self.sideBarVC?.view.frame.size.width = self.SIDEBAR_WIDTH
//        }
//
//        DispatchQueue.main.async {
//            sliding.startAnimation(afterDelay: 0.3)
//        }
//
//        sideBarState = true
//        sliding.stopAnimation(true)
//        completion?()
    }
    
    func removeSideBar() {
        sideBarVC?.removeFromParent()
        sideBarVC?.view.removeFromSuperview()
    }
    
    func closeSideBar(completion: (() -> Void)?) {()
        
//        let slidingOptions = [UIView.AnimationOptions.curveEaseInOut, UIView.ani
        let sliding = UIViewPropertyAnimator(duration: SIDEBAR_SLIDING_TIME, curve: .easeInOut) {
            self.contentVC?.view.frame.origin.x = 0
            self.navVC.navigationBar.frame.origin.x = 0
            self.sideBarVC?.view.frame.size.width = 0
        }
        
        DispatchQueue.main.async {
            sliding.startAnimation()
//            self.removeSideBar()
        }
        sideBarState = false
        sliding.stopAnimation(true)
//        removeSideBar()
        
        completion?()
    }
    
    func addSideBarButton() {
        let barMenu = UIBarButtonItem(image: UIImage(named: "menuBar.png"), style: .plain, target: self, action: #selector(barButtonClicked(_:)))
        contentVC?.navigationItem.leftBarButtonItem = barMenu
    }
    
    @objc func barButtonClicked(_ sender: UIBarButtonItem) {
        if sideBarState {
            closeSideBar(completion: nil)
        } else {
            openSideBar(completion: nil)
        }
    }
    
}
