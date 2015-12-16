//
//  Event.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 15/12/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import Foundation

class Event {
    
    static func delete(eventID: String, next: () -> Void)
    {
        let rc = RestCaller()
        
        rc.delete( "events/\(eventID)", authenticate: true) {
            error, data in
            
            if error != nil {
                print("error on deletion")
                return
            }
            
            next()
        }

    }

}