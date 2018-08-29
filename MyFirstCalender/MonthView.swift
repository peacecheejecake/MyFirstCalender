//
//  MonthView.swift
//  MyFirstCalender
//
//  Created byJiyoung.Jiwon on 26/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class MonthView: UIView {
//    let weeks: [String] = ["Sun", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat"]
    let weeks: [String] = ["S", "M", "T", "W", "T", "F", "S"]
    let daysInMonth: [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    let weekView: UIStackView = UIStackView()
    
    let firstYearOfCalendar: Int = 2018
    var currentYear: Int = 2018
    var selectedDate: (Int, Int) = (Calendar.current.component(.month,from: Date()) - 1, Calendar.current.component(.day, from: Date()) - 1)
    var firstDayOfMonth: Int = 1
    var lastDayOfMonth: Int = 0
    
    
    let GAP: CGFloat = 30
    
    
    var weekLabelWidth: CGFloat {
        let label = UILabel()
        label.text = weeks[0]
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.sizeToFit()
        return label.frame.width
    }
//    var weekLabelSpacing: CGFloat {
//        return abs((self.frame.width - dateSpacing - dateWidth) / 7 - weekLabelWidth * 6 / 7)
//    }
    var dateWidth: CGFloat {
        let label = UILabel()
        label.text = "00"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .ultraLight)
        label.textAlignment = .center
        label.sizeToFit()
        return label.frame.width
    }
    var dateSpacing: CGFloat {
        return abs(self.frame.width / 7 - dateWidth)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        setWeekNameView()
        setupCollection()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setWeekNameView()
        setupCollection()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setWeekNameView() {
        self.backgroundColor = UIColor.clear
        var count = 0
        
        for week in weeks {
            count += 1
            let label = UILabel()
            label.text = week
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 13)
            
            switch count {
            case 1, 7:
                label.textColor = UIColor.subsequent
            default:
                label.textColor = UIColor.main
            }
            
//            label.backgroundColor = UIColor.gray
            
            weekView.addArrangedSubview(label)
        }
        weekView.distribution = .equalSpacing
        
        self.addSubview(weekView)
        weekView.translatesAutoresizingMaskIntoConstraints = false

        weekView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        weekView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (dateSpacing + dateWidth - weekLabelWidth) / 2).isActive = true
        weekView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(dateWidth + dateSpacing - weekLabelWidth) / 2).isActive = true
        
    }
}




extension MonthView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12 * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysInMonth[section % 12] + firstDayOfMonth
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MonthViewCollectionCell
        if indexPath.item >= firstDayOfMonth {
            cell.dateLabel.text = "\(indexPath.item + 1 - firstDayOfMonth)"
        } else {
            cell.dateLabel.text = ""
        }
        
        let bgView = UIView()
        
        bgView.backgroundColor = UIColor.clear
        bgView.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(bgView)
        
        let marginForCircle: CGFloat = 5
        bgView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: -marginForCircle).isActive = true
        bgView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        bgView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: marginForCircle).isActive = true
        bgView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        
        if (indexPath.section, indexPath.item) == selectedDate {
            let bgCircle = UIView()

            bgCircle.backgroundColor = UIColor.main
            bgCircle.translatesAutoresizingMaskIntoConstraints = false
            bgView.addSubview(bgCircle)
            bgCircle.leadingAnchor.constraint(equalTo: bgView.leadingAnchor).isActive = true
            bgCircle.trailingAnchor.constraint(equalTo: bgView.trailingAnchor).isActive = true
            bgCircle.heightAnchor.constraint(equalTo: bgCircle.widthAnchor).isActive = true
            bgCircle.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
            bgCircle.layer.cornerRadius = dateWidth / 2 + marginForCircle
            
            cell.dateLabel.textColor = UIColor.background
        } else {
            cell.dateLabel.textColor = UIColor.main
        }
        
        cell.backgroundView = bgView
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width, height: dateSpacing * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width, height: GAP * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! MonthViewCollectionHeader
        cell.backgroundColor = UIColor.clear
        currentYear = firstYearOfCalendar + (indexPath.section - (indexPath.section % 12)) / 12
        cell.monthLabel.text = (indexPath.section + 1).monthString(simple: true) + " \(currentYear)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: dateWidth, height: GAP)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return dateSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return dateSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = (indexPath.section, indexPath.item)
        collectionView.reloadData()
    }
    
    
    
    func setupCollection() {
        
        let layout = MonthViewCollectionLayout()
        let aMonthView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        aMonthView.dataSource = self
        aMonthView.delegate = self
        
        aMonthView.register(MonthViewCollectionCell.self, forCellWithReuseIdentifier: "cell")
        aMonthView.register(MonthViewCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        aMonthView.showsHorizontalScrollIndicator = false
        aMonthView.showsVerticalScrollIndicator = false
        
        aMonthView.backgroundColor = UIColor.clear
        
        self.addSubview(aMonthView)
        aMonthView.translatesAutoresizingMaskIntoConstraints = false
        
        aMonthView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -dateSpacing / 2).isActive = true
        aMonthView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: dateSpacing / 2).isActive = true
        aMonthView.topAnchor.constraint(equalTo: weekView.bottomAnchor, constant: GAP).isActive = true
        aMonthView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    
}




