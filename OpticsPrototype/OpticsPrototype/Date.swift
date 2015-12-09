//
//  Date.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 09/12/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import Foundation

class Date {
    
    static func ago(d:String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.dateFromString(d)
        
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let earliest = now.earlierDate(date!)
        let latest = (earliest == now) ? date : now
        let components:NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest!, options: NSCalendarOptions())
        
        if (components.year >= 2) {
            
            return "\(components.year) ans"
            
        } else if (components.year >= 1){
            
           return "1 an"
            
        } else if (components.month >= 2) {
            
            return "\(components.month) mois"
            
        } else if (components.month >= 1){
            
            return "1 mois"
            
        } else if (components.weekOfYear >= 2) {
            
            return "\(components.weekOfYear) semaines"
            
        } else if (components.weekOfYear >= 1){
            
            return "1 semaine"
            
        } else if (components.day >= 2) {
            
            return "\(components.day)j"
            
        } else if (components.day >= 1){
           
            return "Hier"
            
        } else if (components.hour >= 2) {
            
            return "\(components.hour)h"
            
        } else if (components.hour >= 1){
            
            return "1h"

        } else if (components.minute >= 2) {
            
            return "\(components.minute) min"
            
        } else if (components.minute >= 1){
            
            return "1 min"
            
        } else if (components.second >= 3) {
            
            return "\(components.second)s"
            
        } else {
            
            return "Maintenant"
            
        }
        
    }
    
}