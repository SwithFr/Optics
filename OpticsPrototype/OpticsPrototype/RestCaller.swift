//
//  RestCaller.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 25/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import Foundation
import UIKit

class RestCaller {
    
    let baseUrl = "http://192.168.99.100/"
    
    var data: String = ""
    var params: [String: String]?
    
    // Set data for post request
    func setData(data: String)
    {
      self.data = data
    }
    
    func setParams(params: [String: String])
    {
        self.params = params
    }
    
    // Perform a request
    private func performRequest(route: String, method: String, authenticate: Bool?, next: (error: NSError?, data: NSData) -> Void )
    {
        let request = makeRequest( route )
        
        request.HTTPMethod = method
        
        if authenticate != nil {
            setHeaders( request )
        }
        
        if self.params != nil {
            for ( key, value ) in self.params! {
                request.addValue( value, forHTTPHeaderField: key )
            }
        }
        
        if method == "POST" || self.data != "" {
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
    
    // Upload an image
    func uploadImage( eventId: String, image: UIImage, next: (error: NSError?, data: NSData) -> Void )
    {
        let request = makeRequest( "pictures" )
        let boundary = generateBoundaryString()
        
        request.HTTPMethod = "POST"
        
        setHeaders( request )
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = UIImageJPEGRepresentation( image, 1 )
        if(imageData==nil) {
            return
        }
        
        let params = [
            "eventId": eventId
        ]
        
        request.HTTPBody = createBodyWithParameters( params, filePathKey: "file", imageDataKey: imageData!, boundary: boundary )
        
        _ = NSURLSession.sharedSession().dataTaskWithRequest( request ) {
            data, response, error in
            
            next(error: error, data: data!)
            
        }.resume()
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
    
    // Generate boundary string
    private func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    private func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
}

// Code get here http://stackoverflow.com/questions/26162616/upload-image-with-parameters-in-swift
extension NSMutableData {
    
    /// Append string to NSMutableData
    ///
    /// Rather than littering my code with calls to `dataUsingEncoding` to convert strings to NSData, and then add that data to the NSMutableData, this wraps it in a nice convenient little extension to NSMutableData. This converts using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `NSMutableData`.
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}