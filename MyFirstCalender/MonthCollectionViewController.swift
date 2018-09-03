//
//  MonthCollectionViewController.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 03/09/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class MonthCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var delegate: MonthViewController?
    
    
    var startingPage: Bool = true
    
    var daysInMonth: [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    let firstYearOfCalendar: Int = 2016
    let lastYearOfCalendar: Int = 2019
    let firstDayOfCalendar: Int = 5
    
    var presentingYear: Int = Calendar.current.component(.year, from: Date())
    var presentingMonth: Int = Calendar.current.component(.month, from: Date())
    var currentYearAfter: Int {
        return presentingYear - firstYearOfCalendar
    }
    
    var yearLabel: UILabel {
        let label = UILabel()
        label.text = "\(presentingYear)"
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .light)
        label.textColor = UIColor.subsequent
        
        return label
    }
    
    
    let firstWeekDayOfThisMonth: Int = {
        let today = Calendar.current.dateComponents([.year, .month], from: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let (year, month) = (String(today.year!), String(format: "%2d", today.month!))
        let formatted = formatter.date(from: "\(year)-\(month)-\(01)")
        
        return Calendar.current.component(.weekday, from: formatted!) - 1
        
    }()
    
    var lastDayOfMonth: Int = 0
    
    var lastSelectedDateIndex: IndexPath?
    var selectedDateIndex: IndexPath?
    
    var todayIndex: IndexPath {
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let date = Calendar.current.component(.day, from: Date())
        
        return IndexPath(item: date - 1 + firstWeekDay(of: month), section: month - 1 + (year - firstYearOfCalendar) * 12)
    }
    
    
    var dateSpacing: CGFloat {
        return dateWidth / 100
    }
    
    var dateWidth: CGFloat {
        return self.view.frame.width / 7.06
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func setup() {
        let layout = MonthViewCollectionFlowLayout()
        
        collectionView.register(MonthViewCollectionCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(MonthViewCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.backgroundColor = UIColor.clear
        
    }
    
    
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12 * (lastYearOfCalendar - firstYearOfCalendar + 1)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        setFebraury(of: section)
        
        return daysInMonth[section % 12] + firstWeekDay(of: section)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let firstDayOfMonth = firstWeekDay(of: indexPath.section)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MonthViewCollectionCell
        
        //        setTodayStyle(cell, at: indexPath)
        
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
        bgView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: marginForCircle).isActive = true
        bgView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        bgView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -marginForCircle).isActive = true
        bgView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        
        if let _ = selectedDateIndex { } else { selectedDateIndex = todayIndex }
        
        if indexPath == selectedDateIndex! {
            let bgCircle = UIView()
            
            bgCircle.backgroundColor = UIColor.main
            bgCircle.translatesAutoresizingMaskIntoConstraints = false
            bgView.addSubview(bgCircle)
            bgCircle.leadingAnchor.constraint(equalTo: bgView.leadingAnchor).isActive = true
            bgCircle.trailingAnchor.constraint(equalTo: bgView.trailingAnchor).isActive = true
            bgCircle.heightAnchor.constraint(equalTo: bgCircle.widthAnchor).isActive = true
            bgCircle.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
            bgCircle.layer.cornerRadius = dateWidth / 2 - marginForCircle
        }
        
        cell.backgroundView = bgView
        
        if indexPath == todayIndex {
            if indexPath == selectedDateIndex {
                cell.dateLabel.textColor = UIColor.background
            } else {
                cell.dateLabel.textColor = UIColor.main
            }
            cell.dateLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .bold)
        } else if indexPath == selectedDateIndex {
            cell.dateLabel.textColor = UIColor.background
            cell.dateLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .ultraLight)
        } else if indexPath.item % 7 == 0 || indexPath.item % 7 == 6 {
            cell.dateLabel.textColor = UIColor.subsequent
            cell.dateLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .ultraLight)
        } else {
            cell.dateLabel.textColor = UIColor.main
            cell.dateLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .ultraLight)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: self.view.frame.width, height: Dimensions.COLLECTIONVIEW_HEADER_HEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == (lastYearOfCalendar - firstYearOfCalendar + 1) * 12 - 1 {
            return CGSize(width: 0, height: Dimensions.COLLECTIONVIEW_VERTICAL_MARGIN)
        } else if section % 12 == 12 - 1 {
            return CGSize.zero
        } else {
            return CGSize.zero
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! MonthViewCollectionHeader
        //        let leadingX = CGFloat(firstWeekDay(of: indexPath.section)) * (dateWidth + dateSpacing) - dateSpacing / 2
        
        cell.delegate = self
        
        cell.backgroundColor = UIColor.clear
        
        cell.monthTitleLabel.text = (indexPath.section + 1).monthString(simple: true)
        
        cell.monthTitleLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        cell.monthTitleLabel.centerYAnchor.constraint(equalTo: cell.topAnchor, constant: cell.frame.height * Dimensions.COLLECTIONVIEW_HEADERTITLE_MULTIPLIER).isActive = true
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: dateWidth, height: dateWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return dateSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return dateSpacing
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lastSelectedDateIndex = selectedDateIndex
        selectedDateIndex = indexPath
        if lastSelectedDateIndex != selectedDateIndex {
            collectionView.reloadItems(at: [selectedDateIndex!, lastSelectedDateIndex!])
        }
        
        if !(delegate?.ifScheduleOpen)! { collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true) }
        delegate?.getTableView()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let collectionView = scrollView as! UICollectionView
        var presentingIndices = collectionView.indexPathsForVisibleItems
        
        if collectionView.indexPathsForVisibleItems != presentingIndices {
            presentingIndices = collectionView.indexPathsForVisibleItems
        }
        
        if presentingIndices != [] {
            presentingMonth = presentingIndices[presentingIndices.count %/ 3].section % 12 + 1
            presentingYear = (presentingIndices[presentingIndices.count %/ 3].section %/ 12) + firstYearOfCalendar
        }
        delegate?.navigationItem.title = "\(presentingMonth.monthString(simple: false)) \(presentingYear)"
        //        delegateForVC?.navigationItem.title = "\(presentingYear)"
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if startingPage {
            delegate?.navigationItem.title = "\(presentingMonth.monthString(simple: false)) \(presentingYear)"
            //            delegateForVC?.navigationItem.title = "\(presentingYear)"
            collectionView.scrollToItem(at: todayIndex, at: .centeredVertically, animated: false)
            startingPage = false
        }
    }

    
}

extension MonthCollectionViewController {
    func setFebraury(of section: Int) {
        let yearOfSection = firstYearOfCalendar + (section %/ 12)
        
        if yearOfSection % 4 == 0 && yearOfSection % 100 != 0 {
            daysInMonth[1] = 29
        } else if yearOfSection % 400 == 0 {
            daysInMonth[1] = 29
        } else {
            daysInMonth[1] = 28
        }
    }
    
    func firstWeekDay(of section: Int) -> Int {
        let year = "\(section %/ 12 + firstYearOfCalendar)"
        let month = String(format: "%2d", section % 12 + 1)


        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let formatted = formatter.date(from: "\(year)-\(month)-\(01)")

        return Calendar.current.component(.weekday, from: formatted!) - 1
    }

}



    

    





