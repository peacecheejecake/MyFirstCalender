//
//  MonthScheduleViewController.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 30/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class MonthScheduleViewController: UITableViewController {
    var delegate: WeekNameView?
    
    override func viewDidLoad() {
        setup()
    }
    
    func setup() {
        self.view.backgroundColor = UIColor.subBG
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    //MARK - TABLEVIEW DELEGATE & DATASOURCE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as? MonthViewScheduleCell ?? MonthViewScheduleCell()
        cell.backgroundColor = UIColor.subBG
        cell.startingTime.text = "09:00"
        cell.endingTime.text = "10:00"
        
        
        return cell
    }
    
}
