//
//  RestCaller.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 25/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import Foundation

class RestCaller {
    
    let baseUrl = "http://192.168.99.100/"
    
    var data: String = ""
    
    // Set data for post request
    func setData(data: String)
    {
      self.data = data
    }
    
    // Perform a request
    private func performRequest(route: String, method: String, authenticate: Bool?, next: (error: NSError?, data: NSData) -> Void )
    {
        let request = makeRequest( route )
        
        request.HTTPMethod = method
        
        if authenticate != nil {
            setHeaders( request )
        }
        
        if method == "POST" {
            request.HTTPBody = self.data.dataUsingEncoding( NSUTF8StringEncoding )
        }
        
        _ = NSURLSession.sharedSession().dataTaskWithRequest( request ) {
            data, response, error in
            
            next(error: error, data: data!)
            
        }.resume()
        
    }
    
    // Make a POST request
    func post( route: String, authenticate: Bool?, next: (error: NSError?, data: NSData) -> Void )
    {
        performRequest(route, method: "POST", authenticate: authenticate, next: next)
    }
    
    // Make a GET request
    func get( route: String, authenticate: Bool?, next: (error: NSError?, data: NSData) -> Void )
    {
        performRequest(route, method: "GET", authenticate: authenticate, next: next)
    }
    
    // Make a DELETE request
    func delete( route: String, authenticate: Bool?, next: (error: NSError?, data: NSData) -> Void )
    {
        performRequest(route, method: "DELETE", authenticate: authenticate, next: next)
    }
    
    // Set header for authentification
    private func setHeaders(request: NSMutableURLRequest)
    {
        request.addValue( User.getUserProperty( "USER_TOKEN" ) as! String, forHTTPHeaderField: "usertoken")
        request.addValue( (User.getUserProperty( "USER_ID" )?.stringValue)!, forHTTPHeaderField: "userid" )
    }
    
    // Create a request with an URL
    private func makeRequest(route: String) -> NSMutableURLRequest
    {
        return NSMutableURLRequest( URL: NSURL( string: self.baseUrl + route )! )
    }
    
}