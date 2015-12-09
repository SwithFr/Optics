//
//  Picture.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 02/12/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import Foundation
import UIKit

class Picture {
    
    static func delete(pictureId: String, next: () -> Void)
    {
        let rc = RestCaller()
        rc.delete( "pictures/\(pictureId)", authenticate: true) {
            error, data in
            
            if error != nil {
                print("error on deletion")
                return
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                next()
            }
        }

    }
    
}