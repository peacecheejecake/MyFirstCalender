//
//  MonthViewController.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 26/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class MonthViewController: UIViewController {    
    override func viewDidLoad() {
        setup()
    }
    
    func setup() {
        let monthView = MonthView()
//        let backgroundView = UIScrollView()
        
        monthView.delegateForVC = self
        
        view.addSubview(monthView)
        
        view.backgroundColor = UIColor.white
        
//        navigationItem.title = "\(monthView.currentMonth.monthString(simple: false)) \(monthView.currentYear)"
        
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.main
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.main]
        navigationController?.navigationBar.barTintColor = UIColor.background
        view.backgroundColor = UIColor.background
//        navigationController?.navigationBar.frame.size.height = 200
//        navigationController?.navigationBar.frame.origin.y -= 100
        
        pin(to: monthView)
        
        viewRespectsSystemMinimumLayoutMargins = false
    }
}

extension MonthViewController {
    func pin(to view_: UIView) {
        let HORIZONTAL_MARGIN: CGFloat = UIScreen.main.bounds.width / 12
        let VERTICAL_MARGIN: CGFloat = UIScreen.main.bounds.height / 12
//        let margins = self.view.layoutMarginsGuide
        
        view_.translatesAutoresizingMaskIntoConstraints = false
        
        view_.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: HORIZONTAL_MARGIN).isActive = true
        view_.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -HORIZONTAL_MARGIN).isActive = true
//        view_.topAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!, constant: 30).isActive = true
        view_.topAnchor.constraint(equalTo: self.view.topAnchor, constant: VERTICAL_MARGIN + (navigationController?.navigationBar.frame.height)!).isActive = true
        view_.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
    }
}

//extension MonthViewController: UICollectionViewDataSource {
//    
//}
