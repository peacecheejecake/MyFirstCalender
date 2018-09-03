//
//  Date+extensions.swift
//  MyFirstCalender
//
//  Created by Jiyoung.Jiwon on 29/08/2018.
//  Copyright © 2018 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

infix operator %/ : MultiplicationPrecedence

extension Int {
    func monthString(simple: Bool) -> String {
        if simple {
            switch self % 12 {
            case 1:
                return "Jan"
            case 2:
                return "Feb"
            case 3:
                return "Mar"
            case 4:
                return "Apr"
            case 5:
                return "May"
            case 6:
                return "Jun"
            case 7:
                return "Jul"
            case 8:
                return "Aug"
            case 9:
                return "Sep"
            case 10:
                return "Oct"
            case 11:
                return "Nov"
            case 0, 12:
                return "Dec"
            default:
                return ""
            }
            
        } else {
            switch self {
            case 1:
                return "January"
            case 2:
                return "Febraury"
            case 3:
                return "March"
            case 4:
                return "April"
            case 5:
                return "May"
            case 6:
                return "June"
            case 7:
                return "July"
            case 8:
                return "August"
            case 9:
                return "September"
            case 10:
                return "October"
            case 11:
                return "November"
            case 0, 12:
                return "December"
            default:
                return ""
                
            }
        }
    }
    
    
    static func %/(left: Int, right: Int) -> Int {
        return (left - left % right) / right
    }
}
