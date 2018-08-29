//
//  FirstViewController.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 24/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    var delegate: MasterViewController?
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        
        let label = UILabel()
        label.text = "First View"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.textColor = UIColor.gray
        label.center = self.view.center
        self.view.addSubview(label)
        
//        addSideBarButton()
        
        navigationItem.title = "Welcome!"
        
        if SettingManager.theme == .Dark {
            navigationItem.leftBarButtonItem?.tintColor = UIColor.white
            navigationController?.navigationBar.barTintColor = UIColor.black
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            view.backgroundColor = UIColor.black
        } else {
            navigationItem.leftBarButtonItem?.tintColor = UIColor.black
            navigationController?.navigationBar.barTintColor = UIColor.white
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
            view.backgroundColor = UIColor.white
        }
    }
    
//    @objc func barButtonClicked(_ sender: UIBarButtonItem) {
//        if (delegate?.sideBarState)! {
//            delegate?.closeSideBar(completion: nil)
//        } else {
//            delegate?.openSideBar(completion: nil)
//        }
//    }
//
//    func addSideBarButton() {
//        let bbt = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(barButtonClicked(_:)))
//        navigationItem.leftBarButtonItem = bbt
//
//    }
}
