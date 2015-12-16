//
//  Comment.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 15/12/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import Foundation

class Comment {
 
    static func add(comment: String, pictureid: String, eventid: String, next: (data: NSData) -> Void)
    {
        let rc = RestCaller()
        rc.setData( "comment=\(comment)" )
        rc.setParams( [ "pictureid": pictureid, "eventid": eventid ] )
        rc.post( "comments", authenticate: true) {
            error, data in
            
            if error != nil {
                print( "Error when add comment" )
            }
            
            next( data: data )
        }
    }
    
    static func getAllFromPicture( pictureid: String, next: (data: NSData) -> Void )
    {
        let rc = RestCaller()
        rc.setParams( [ "pictureid": pictureid ] )
        rc.get( "comments", authenticate: true) {
            error, data in
            
            if error != nil {
                print( "Error when getting comments" )
            }
            
            
            dispatch_async(dispatch_get_main_queue()) {
                next( data: data )
            }
        }

    }
    
}