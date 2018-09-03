//
//  MonthViewScheduleCell.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 03/09/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class MonthViewScheduleCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)  {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: "tableCell")
        setup()
    }
    
    let startingTime = UILabel()
    let endingTime = UILabel()
    let groupColor = UIView()
    let contentLabel = UILabel()
    
    func setup() {
        setTimeText()
        setGroupView()
    }
    
    func setTimeText() {
        startingTime.text = "Starting Time"
        startingTime.textColor = UIColor.main
        startingTime.font = UIFont.systemFont(ofSize: 11)
        startingTime.sizeToFit()
        startingTime.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(startingTime)
        startingTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: startingTime.frame.height).isActive = true
        startingTime.topAnchor.constraint(equalTo: topAnchor, constant: startingTime.frame.height / 2).isActive = true
        
        endingTime.text = "Ending Time"
        endingTime.textColor = UIColor.subsequent
        endingTime.font = UIFont.systemFont(ofSize: 11)
        endingTime.sizeToFit()
        endingTime.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(endingTime)
        endingTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: endingTime.frame.height).isActive = true
        endingTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -endingTime.frame.height / 2).isActive = true
        
    }
    
    func setGroupView() {
        groupColor.backgroundColor = UIColor.red
        groupColor.frame.size = CGSize(width: 10, height: 10)
        groupColor.layer.cornerRadius = 10
        groupColor.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(groupColor)
        groupColor.leadingAnchor.constraint(equalTo: endingTime.trailingAnchor, constant: 5).isActive = true
        groupColor.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
}
