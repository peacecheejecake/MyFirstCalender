//
//  SideBarViewController.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 24/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

enum SideBarList: String, CaseIterable {
    case Month, Settings
}
//extension SideBarList: CaseIterable { }

class SideBarViewController: UITableViewController {
    var delegate: MasterViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
        headerView.backgroundColor = UIColor.darkGray
        tableView.tableHeaderView = headerView
        
        delegate?.contentVC?.navigationController?.navigationBar.removeFromSuperview()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SideBarList.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideCell") ?? UITableViewCell(style: .default, reuseIdentifier: "sideCell")
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.darkGray
        cell.textLabel?.text = SideBarList.allCases[indexPath.row].rawValue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.closeSideBar(completion: nil)
        
        
        switch indexPath.row {
        case 0:
            delegate?.contentVC = MonthViewController()
        case 1:
            delegate?.contentVC = SettingViewController()
        default:
            ()
        }
        
        delegate?.navVC.viewControllers.removeFirst()
        delegate?.navVC.viewControllers.append((delegate?.contentVC)!)
        delegate?.addSideBarButton()
        

//        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = settingVC.navVC
    }
}
