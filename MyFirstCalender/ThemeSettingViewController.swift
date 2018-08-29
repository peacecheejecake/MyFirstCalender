//
//  ThemeSettingViewController.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 24/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

enum ThemeOptions: String, CaseIterable {
    case Dark, Light
    
    static var options: [String] {
        switch SettingManager.language {
        case .English:
            return ["Dark", "Light"]
        case .Korean:
            return ["어두움", "밝음"]
        }
    }
}

class ThemeSettingViewController: UITableViewController, SettingProtocol {
    var options = ["Dark", "Light"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Theme"
//        settingManager.themeDelegate = self
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ThemeOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "themeCell") ?? UITableViewCell(style: .value1, reuseIdentifier: "themeCell")
        
        cell.textLabel?.text = options[indexPath.row]
        
        if ThemeOptions.allCases[indexPath.row] == SettingManager.theme {
//            cell.accessoryType = .checkmark
            let radius: CGFloat = 3

            let checkCircleView = UIView(frame: CGRect(x: cell.bounds.maxX - radius * 3, y: cell.bounds.maxY - radius, width: radius * 2, height: radius * 2))
            checkCircleView.layer.cornerRadius = radius
            checkCircleView.clipsToBounds = true
            checkCircleView.backgroundColor = UIColor.main
            cell.accessoryView = checkCircleView
        } else {
//            cell.accessoryType = .none
            let dummyView = UIView()
            cell.accessoryView = dummyView
            
        }
        
        cell.backgroundColor = UIColor.background
        tableView.backgroundColor = UIColor.background
        navigationController?.navigationBar.barTintColor = UIColor.background
        cell.textLabel?.textColor = UIColor.main
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.main]
        navigationController?.navigationBar.tintColor = UIColor.main
        
        
//        ThemeManager.setTheme(for: navigationController?.navigationBar)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SettingManager.theme = ThemeOptions.allCases[indexPath.row]
        tableView.reloadData()
    }
}


class CheckmarkForTableViewCell: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var color = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let x = self.bounds.maxX - 3
        let y = self.bounds.maxY / 2
        let R: CGFloat = 4.5
        
        context?.move(to: CGPoint(x: x - 3, y: y / 2))
        context?.addLine(to: CGPoint(x: x, y: y))
        context?.addLine(to: CGPoint(x: x - R , y: bounds.maxY - y / 3))
        context?.setLineCap(CGLineCap.square)
        context?.setLineJoin(CGLineJoin.miter)
        context?.setLineWidth(2)
        color.setStroke()
        context?.strokePath()
    }
    
}
