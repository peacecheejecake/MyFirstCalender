//
//  ThemeManager.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 27/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class ThemeManager {
    static let mainColor = UIColor.main
    static let backgroundColor = UIColor.background
    
    static func setTheme(for tableView: UITableView) {
        tableView.backgroundColor = backgroundColor
    }
    
    static func setTheme(for tableViewCell: UITableViewCell) {
        tableViewCell.textLabel?.textColor = mainColor
        tableViewCell.backgroundColor = backgroundColor
    }
    
    static func setTheme(for navigationBar: UINavigationBar?) {
        navigationBar?.barTintColor = backgroundColor
        navigationBar?.titleTextAttributes = [.foregroundColor: mainColor]
        navigationBar?.tintColor = mainColor
    }
    
    static func setTheme(_ tableViewCell: UITableViewCell, _ tableView: UITableView, _ navigationBar: UINavigationBar?) {
        setTheme(for: tableView)
        setTheme(for: tableViewCell)
        setTheme(for: navigationBar)
    }
}

