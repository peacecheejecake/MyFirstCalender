//
//  MonthView.swift
//  MyFirstCalender
//
//  Created byJiyoung.Jiwon on 26/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class MonthView: UIView {
    var delegateForVC: MonthViewController?
    
    var startingPage: Bool = true
    
//    let weeks: [String] = ["Sun", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat"]
    let weeks: [String] = ["S", "M", "T", "W", "T", "F", "S"]
    var daysInMonth: [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    let weekView: UIStackView = UIStackView()
    
    let firstYearOfCalendar: Int = 2016
    let lastYearOfCalendar: Int = 2019
    var currentYear: Int = Calendar.current.component(.year, from: Date())
    var currentYearAfter: Int {
        return currentYear - firstYearOfCalendar
    }
    
    var yearLabel: UILabel {
        let label = UILabel()
        label.text = "\(currentYear)"
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .light)
        label.textColor = UIColor.subsequent
        
        return label
    }
    
    var firstDayOfCalendar: Int = 1
    var firstDayOfMonth: Int = 1
    var lastDayOfMonth: Int = 0
    
    var selectedDateIndex: (Int, Int)?
    
    var todayIndex: (Int, Int) {
        let month = Calendar.current.component(.month, from: Date())
        let date = Calendar.current.component(.day, from: Date())
        
        return (month - 1 - (currentYearAfter %/ 12), date - 1 + firstDayOfMonth)
    }
    
    
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
    
    let dateHeight: CGFloat = 30
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
        return 12 * (lastYearOfCalendar - firstYearOfCalendar + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let yearOfCurrentSection = firstYearOfCalendar + (section %/ 12)
        
        if yearOfCurrentSection % 4 == 0 && yearOfCurrentSection % 100 != 0 {
            daysInMonth[1] = 29
        } else if yearOfCurrentSection % 400 == 0 {
            daysInMonth[1] = 29
        } else {
            daysInMonth[1] = 28
        }
        
        return daysInMonth[section % 12] + firstDayOfMonth
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MonthViewCollectionCell
        
//        setTodayStyle(cell, at: indexPath)
        
        if indexPath.item >= firstDayOfMonth {
            cell.dateLabel.text = "\(indexPath.item + 1 - firstDayOfMonth)"
        } else {
            cell.dateLabel.text = ""
        }
        

        if (indexPath.section, indexPath.item) == todayIndex {
            cell.dateLabel.textColor = UIColor.highlight
            print(indexPath.section, indexPath.item)
            print(todayIndex)
        } else if indexPath.item % 7 == 0 || indexPath.item % 7 == 6 {
            cell.dateLabel.textColor = UIColor.subsequent
        } else {
            cell.dateLabel.textColor = UIColor.main
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
        
        if let _ = selectedDateIndex { } else { selectedDateIndex = todayIndex }
        
        if (indexPath.section, indexPath.item) == selectedDateIndex! {
            let bgCircle = UIView()

            bgCircle.backgroundColor = UIColor.main
            bgCircle.translatesAutoresizingMaskIntoConstraints = false
            bgView.addSubview(bgCircle)
            bgCircle.leadingAnchor.constraint(equalTo: bgView.leadingAnchor).isActive = true
            bgCircle.trailingAnchor.constraint(equalTo: bgView.trailingAnchor).isActive = true
            bgCircle.heightAnchor.constraint(equalTo: bgCircle.widthAnchor).isActive = true
            bgCircle.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
            bgCircle.layer.cornerRadius = dateWidth / 2 + marginForCircle
            
            if indexPath.item == todayIndex.1 {
                cell.dateLabel.textColor = UIColor.highlight
            } else {
                cell.dateLabel.textColor = UIColor.background
            }
            
        } else if indexPath.item % 7 == 0 || indexPath.item % 7 == 6 {
            cell.dateLabel.textColor = UIColor.subsequent
        } else if (indexPath.row, indexPath.item) == todayIndex {
            cell.dateLabel.textColor = UIColor.highlight
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
        return CGSize(width: self.frame.width, height: dateHeight * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! MonthViewCollectionHeader
        
        cell.delegate = self
        
        cell.backgroundColor = UIColor.clear
        currentYear = firstYearOfCalendar + (indexPath.section - (indexPath.section % 12)) / 12
        cell.monthLabel.text = (indexPath.section + 1).monthString(simple: true)
        
        cell.monthLabel.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        cell.monthLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: CGFloat(firstDayOfMonth) * (dateWidth + dateSpacing) - dateSpacing / 2).isActive = true
        cell.monthLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        cell.monthLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -dateSpacing).isActive = true

        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: dateWidth, height: dateHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return dateSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return dateSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDateIndex = (indexPath.section, indexPath.item)
        collectionView.reloadData()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegateForVC?.navigationItem.title = "\(currentYear)"
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegateForVC?.navigationItem.title = "\(currentYear)"
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let indexToScrollTo = IndexPath(item: todayIndex.1, section: todayIndex.0)
        if startingPage {
            collectionView.scrollToItem(at: indexToScrollTo, at: .centeredVertically, animated: false)
            startingPage = false
        }
        
    }
    
    
    
    
    
    func setupCollection() {

        let layout = MonthViewCollectionFlowLayout()
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
        aMonthView.topAnchor.constraint(equalTo: weekView.bottomAnchor, constant: dateHeight * 2).isActive = true
        aMonthView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    
    
    func setTodayStyle(_ cell: MonthViewCollectionCell, at indexPath: IndexPath) {
        selectedDateIndex = todayIndex
        
        print(todayIndex)
        
        if (indexPath.section, indexPath.item) == todayIndex {
            cell.dateLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .bold)
            cell.dateLabel.textColor = UIColor.red
            cell.dateLabel.sizeToFit()
        }
    }
    
}




