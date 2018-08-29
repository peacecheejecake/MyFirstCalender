//
//  MonthViewCollectionHeader.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 29/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class MonthViewCollectionHeader: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupHeader()
    }
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "Jan"
        label.textColor = UIColor.main
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    func setupHeader() {
        addSubview(monthLabel)
        
        monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        monthLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        monthLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        monthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: 0, y: self.bounds.maxY))
        context?.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY))
        context?.setLineCap(.square)
        context?.setLineJoin(.miter)
        context?.setLineWidth(1.0)
//        UIColor.main.setStroke()
        context?.setStrokeColor(UIColor.main.cgColor)
        setNeedsLayout()
        context?.strokePath()
    }
}
