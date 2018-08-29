//
//  SettingManager.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 23/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

struct SettingKeys {
    static let language = "LANGUAGE"
    static let theme = "THEME"
}

protocol SettingProtocol {
//    func translate(to: LanguageOptions) -> Void
    
    var options: [String] { get }
}

struct SettingManager {
//    var themeDelegate: ThemeSettingViewController?
    
    static let ud = UserDefaults.standard
    static let languageKey = SettingKeys.language
    static let themeKey = SettingKeys.theme
    
    static let defaultLanguage = LanguageOptions.English
    static let defaultTheme = ThemeOptions.Light
    
    static var language: LanguageOptions {
        get {
            guard let currentLanguage = ud.string(forKey: languageKey) else {
                ud.set(defaultLanguage.rawValue, forKey: languageKey)
                ud.synchronize()
                
                return defaultLanguage
            }
            
            return LanguageOptions(rawValue: currentLanguage)!
        }
        
        set(v) {
            ud.set(v.rawValue, forKey: languageKey)
            ud.synchronize()
        }
    }
    static var theme: ThemeOptions {
        get {
            guard let currentTheme = ud.string(forKey: themeKey) else {
                ud.set(defaultTheme.rawValue, forKey: themeKey)
                ud.synchronize()
                
                return defaultTheme
            }
            
            return ThemeOptions(rawValue: currentTheme)!
        }
        
        set(v) {
            ud.set(v.rawValue, forKey: themeKey)
            ud.synchronize()
        }
    }

    static var options = ["Language", "Theme"]

//    init() {
//        if let currentLanguage = ud.string(forKey: languageKey), let currentTheme = ud.string(forKey: themeKey) {
//            language = LanguageOptions(rawValue: currentLanguage)!
//            theme = ThemeOptions(rawValue: currentTheme)!
//        } else {
//            language = defaultLanguage
//            theme = defaultTheme
//
//            ud.set(defaultLanguage, forKey: languageKey)
//            ud.set(defaultTheme, forKey: themeKey)
//            ud.synchronize()
//        }
//    }
}
    
//    var language: LanguageOptions {
//        get {
//            let key = SettingKeys.language
//            let defaultOption = LanguageOptions.English
//
//            guard let current = ud.string(forKey: key) else {
//                ud.set(defaultOption.rawValue, forKey: key)
//                ud.synchronize()
//                return defaultOption
//            }
//
//            return LanguageOptions(rawValue: current)!
//        }
//
//        set(v) {
//            ud.set(v.rawValue, forKey: SettingKeys.language)
//            ud.synchronize()
//
////            changeLanguage()
////            print(v)
//        }
//    }
//
//    var theme: ThemeOptions {
//        get {
//            let ud = UserDefaults.standard
//
//            let key = SettingKeys.theme
//            let defaultOption = ThemeOptions.Dark
//
//            guard let current = ud.string(forKey: key) else {
//                ud.set(defaultOption.rawValue, forKey: key)
//                ud.synchronize()
//                return defaultOption
//            }
//
//            return ThemeOptions(rawValue: current)!
//        }
//
//        set(v) {
//            ud.set(v.rawValue, forKey: SettingKeys.theme)
//            ud.synchronize()
//
//            themeChange(to: v)
//        }
//    }

    
//    static func themeChange(to theme: ThemeOptions) {
//        switch theme {
//        case .Dark:
//            themeDelegate?.tableView.backgroundColor = UIColor.black
//
//        case .Light:
//            ()
//        }
//    }
    
//    static func changeLanguage() {
//
//    }
//}
