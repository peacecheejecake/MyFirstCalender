//
//  LanguageSettingViewController.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 24/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit


enum LanguageOptions: String, CaseIterable {
    case Korean, English
}

class LanguageSettingViewController: UITableViewController, UINavigationControllerDelegate, SettingProtocol {
    
    var selected = SettingManager.language
    
    let key = SettingKeys.language
    let ud = UserDefaults.standard
    
    var options = ["Korean", "English"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Language"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(selectedDone(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(selectedCancel(_:)))
    }
    
    @objc func selectedDone(_ sender: UIBarButtonItem) {
        SettingManager.language = selected
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func selectedCancel(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LanguageOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "langCell") ?? UITableViewCell(style: .default, reuseIdentifier: "langCell")
        
        cell.textLabel?.text = self.options[indexPath.row]
        
        if LanguageOptions.allCases[indexPath.row] == selected {
//            cell.accessoryType = .checkmark
            let radius: CGFloat = 3
            var circleColor: UIColor {
                if SettingManager.theme == .Dark {
                    return .white
                } else {
                    return .black
                }
            }
            let checkCircleView = UIView(frame: CGRect(x: cell.bounds.maxX - 3 * radius, y: cell.bounds.maxY / 2, width: 2 * radius, height: 2 * radius))
            checkCircleView.layer.cornerRadius = radius
            checkCircleView.backgroundColor = circleColor
            checkCircleView.clipsToBounds = false
            
            cell.accessoryView = checkCircleView
        } else {
//            cell.accessoryType = .none
            let dummyView = UIView()
            cell.accessoryView = dummyView
        }
        cell.textLabel?.textColor = UIColor.main

        cell.backgroundColor = UIColor.background
        tableView.backgroundColor = UIColor.background
        navigationController?.navigationBar.barTintColor = UIColor.background
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.main]
        navigationController?.navigationBar.tintColor = UIColor.main
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = LanguageOptions.allCases[indexPath.row]
        tableView.reloadData()
        
//        print("manager: \(SettingManager.language)")
//        print("ud: \(ud.string(forKey: key))")
    }
    
}
