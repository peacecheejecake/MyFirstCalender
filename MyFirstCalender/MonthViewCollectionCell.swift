//
//  MonthViewCollectionCell.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 28/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class MonthViewCollectionCell: UICollectionViewCell {
        override init(frame: CGRect) {
        super.init(frame: frame)
            
        pin()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var length: CGFloat {
        return dateLabel.frame.width
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textColor = UIColor.main
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .ultraLight)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
            
        return label
    }()
    
    func pin() {
        addSubview(dateLabel)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: dateLabel.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
    }
}
