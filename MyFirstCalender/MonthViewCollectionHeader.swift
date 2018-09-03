//
//  MonthViewCollectionHeader.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 29/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class MonthViewCollectionHeader: UICollectionViewCell {
    var delegate: MonthCollectionViewController?
    
//    let BOTTOM_SPACING: CGFloat = 30
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupHeader()
    }
    
    let monthTitleLabel = MonthLabel()
    
    
    func setupHeader() {
//        monthLabel.delegate = self
        
        addSubview(monthTitleLabel)
//        if let delegate = delegate {
        
//            let leadingX = CGFloat(delegate.firstWeekDayOfMonth) * (delegate.dateWidth + delegate.dateSpacing) - delegate.dateSpacing / 2
//
//            let spacing = 15
            
//        monthTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        monthTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -self.frame.height / 3 - 0.5).isActive = true
//        }
        
    }
    
    
    
    override func draw(_ rect: CGRect) {
//        let context = UIGraphicsGetCurrentContext()
//
//
//        if let delegate = delegate {
//
//            let spacing = delegate.dateSpacing / 2
//            var lineColor: UIColor = .main {
//                didSet {
//                    setNeedsLayout()
//                }
//            }
//
//            context?.move(to: CGPoint(x: CGFloat(delegate.firstDayOfMonth) * (delegate.dateWidth + delegate.dateSpacing) - delegate.dateSpacing / 2, y: monthLabel.bounds.maxY + spacing))
//            context?.addLine(to: CGPoint(x: self.bounds.maxX, y: monthLabel.bounds.maxY + spacing))
//            context?.setLineCap(.square)
//            context?.setLineJoin(.miter)
//            context?.setLineWidth(0.5)
//            lineColor.setStroke()
//            context?.setStrokeColor(lineColor.cgColor)
//            setNeedsLayout()
//            context?.strokePath()
//
            let path = UIBezierPath()

//            path.move(to: CGPoint(x: CGFloat(delegate.firstDayOfMonth) * (delegate.dateWidth + delegate.dateSpacing) - delegate.dateSpacing / 2, y: monthLabel.bounds.maxY))
            path.move(to: CGPoint(x: monthTitleLabel.bounds.maxX * 1.5, y: self.bounds.maxY / 3 * 2 - monthTitleLabel.frame.height / 2))
            path.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY / 3 * 2 - monthTitleLabel.frame.height / 2))
            path.lineWidth = 0.5
            UIColor.main.setStroke()
            setNeedsLayout()
//            path.stroke()
//        }
//
    }
}

class MonthLabel: UILabel {
//    var delegate: MonthViewCollectionHeader?
//    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.text = "Jan"
        self.textColor = UIColor.main
        self.font = UIFont.monospacedDigitSystemFont(ofSize: 19, weight: .bold)
        self.textAlignment = .left
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.background
        self.baselineAdjustment = .alignBaselines
    }
}
