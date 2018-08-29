//
//  SettingViewController.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 23/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {    
    let navVC = UINavigationController()
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Settings"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewForHeader = UIView()
//        viewForHeader.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 0)
        var bgColor: UIColor {
            if SettingManager.theme == .Dark {
                return UIColor(white: 1.0, alpha: 0.075)
            } else {
                return UIColor(white: 0, alpha: 0.075)
            }
        }
        
        viewForHeader.backgroundColor = bgColor
        
        return viewForHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 20
        }
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 10
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return SettingManager.options.count
        case 1:
            return 1
        case 2:
            return 3
        default:
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = SettingManager.options[indexPath.row]
            cell.imageView?.image = UIImage()
            
            switch indexPath.row {
            case 0:
                cell.detailTextLabel?.text = SettingManager.language.rawValue
            case 1:
                cell.detailTextLabel?.text = SettingManager.theme.rawValue
            default:
                ()
            }
            
        default:
            ()
        }
        
        cell.backgroundColor = UIColor.background
        tableView.backgroundColor = UIColor.background
        navigationController?.navigationBar.barTintColor = UIColor.background
        cell.textLabel?.textColor = UIColor.main
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.main]
        navigationController?.navigationBar.tintColor = UIColor.main
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var newVC: UITableViewController?
        
        switch indexPath.row {
        case 0:
            newVC = LanguageSettingViewController()
        case 1:
            newVC = ThemeSettingViewController()
        default:
            ()
        }
//
//        if indexPath.row == 0 {
//            present(newVC!, animated: true, completion: nil)
//        } else {
//            navigationController?.pushViewController(newVC!, animated: true)
//        }
        
        navigationController?.pushViewController(newVC!, animated: true)
    }

}
