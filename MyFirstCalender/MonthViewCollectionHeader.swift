//
//  MonthViewCollectionHeader.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 29/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class MonthViewCollectionHeader: UICollectionViewCell {
    var delegate: MonthView?
    
    
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
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 19, weight: .light)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.backgroundColor = UIColor.clear
        
        return label
    }()
    
    
    func setupHeader() {
        addSubview(monthLabel)
//
//        monthLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        monthLabel.bottomAnchor .constraint(equalTo: bottomAnchor).isActive = true
//        monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        monthLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//
//        if let delegate = delegate {
////            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(delegate.firstDayOfMonth) * (delegate.dateWidth + delegate.dateSpacing)).isActive = true
//            monthLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat(6 - delegate.firstDayOfMonth) * (delegate.dateWidth + delegate.dateSpacing)).isActive = true

//        }

    }
    
    
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        
        if let delegate = delegate {
        
            let spacing = delegate.dateSpacing / 2
            
            context?.move(to: CGPoint(x: CGFloat(delegate.firstDayOfMonth) * (delegate.dateWidth + delegate.dateSpacing) - delegate.dateSpacing / 2, y: monthLabel.bounds.maxY + spacing))
            context?.addLine(to: CGPoint(x: self.bounds.maxX, y: monthLabel.bounds.maxY + spacing))
            context?.setLineCap(.square)
            context?.setLineJoin(.miter)
            context?.setLineWidth(0.5)
            //        UIColor.main.setStroke()
            context?.setStrokeColor(UIColor.main.cgColor)
            setNeedsLayout()
            context?.strokePath()
        }
        
    }
}
