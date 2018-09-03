//
//  UIColor+extension.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 28/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit


extension UIColor {
    static var main: UIColor {
        switch SettingManager.theme {
        case .Dark:
            return .white
        case .Light:
            return .black
        }
    }
    
    static var subsequent: UIColor {
        switch SettingManager.theme {
        case .Dark:
            return .lightGray
        case .Light:
            return .lightGray
        }
    }
    
    static var background: UIColor {
        switch SettingManager.theme {
        case .Dark:
            return .black
        case .Light:
            return .white
        }
    }
    
    static var subBG: UIColor {
        switch SettingManager.theme {
        case .Dark:
            return .darkGray
        case .Light:
            return .darkGray
        }
    }
    
    static var highlight: UIColor {
        return .red
    }
}
