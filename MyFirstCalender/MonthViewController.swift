//
//  MonthViewController.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 26/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class MonthViewController: UIViewController {
    
    let weekNameView = WeekNameView()
    let collectionVC = MonthCollectionViewController()
    let scheduleVC = MonthScheduleViewController()

    var ifScheduleOpen = false

    
    override func viewDidLoad() {
        setup()
    }
    
    func setup() {
//        navigationItem.title = "\(monthView.currentMonth.monthString(simple: false)) \(monthView.currentYear)"
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.main
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.main]
        navigationController?.navigationBar.barTintColor = UIColor.background
        view.backgroundColor = UIColor.background
//        navigationController?.navigationBar.frame.size.height = 200
//        navigationController?.navigationBar.frame.origin.y -= 100
        
        pin(to: collectionVC.view)
        
        viewRespectsSystemMinimumLayoutMargins = false
    }
    
    func pin(to view_: UIView) {

//        let margins = self.view.layoutMarginsGuide
        
        view_.translatesAutoresizingMaskIntoConstraints = false
        
        view_.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: HORIZONTAL_MARGIN).isActive = true
        view_.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -HORIZONTAL_MARGIN).isActive = true
//        view_.topAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!, constant: 30).isActive = true
        view_.topAnchor.constraint(equalTo: self.view.topAnchor, constant: VERTICAL_MARGIN + (navigationController?.navigationBar.frame.height)!).isActive = true
//        view_.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
    }
    
    func setWeekName() {
        
        let weekLabelWidth: CGFloat = {
            let label = UILabel()
            label.text = "S"
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 13)
            label.sizeToFit()
            
            return label.frame.width
        }()
        
        self.view.addSubview(weekNameView)
        
        weekNameView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        weekNameView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -UIScreen.main.bounds.width / 12 * 11 / 7.06 + weekLabelWidth + 6).isActive = true
        weekNameView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func setupCollection() {
        collectionVC.delegate = self
        
        self.addChild(collectionVC)
        self.view.addSubview(collectionVC.view)
        collectionVC.didMove(toParent: self)
        
        let collectionView = (collectionVC.view)!
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: weekNameView.bottomAnchor, constant: Dimensions.COLLECTIONVIEW_VERTICAL_MARGIN).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Dimensions.COLLECTIONVIEW_VERTICAL_MARGIN).isActive = true
    }
    
    func getTableView() {
        
        self.addChild(scheduleVC)
        self.view.addSubview(scheduleVC.view)
        scheduleVC.didMove(toParent: self)
        
        scheduleVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = false
        scheduleVC.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.view.frame.height * 0.5).isActive = true
        
        scheduleVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scheduleVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scheduleVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scheduleVC.view.topAnchor.constraint(equalTo: monthView.bottomAnchor).isActive = true
    
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            monthView.frame.size.height = self.view.frame.height
        }, completion: { _ in self.ifScheduleOpen = true })
    }
}

//extension MonthViewController: UICollectionViewDataSource {
//    
//}

