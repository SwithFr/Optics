//
//  MainViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 04/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController {

    override func viewWillAppear(animated: Bool)
    {
        
        if !User.isAuthenticated() {
            let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier( "loginScreen" )
            pushViewController( loginVC!, animated: true )
        }
        
    }

}

extension UIViewController {
    
    func showLoader(msg: String)
    {
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        let message = UILabel( frame: CGRect( x: 50, y: 0, width: 200, height: 50 ) )
        let container = UIView( frame: CGRect( x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 180, height: 50 ) )
        
        actInd.activityIndicatorViewStyle = .White
        message.text = msg
        message.textColor = UIColor.whiteColor()
        container.layer.cornerRadius = 15
        container.backgroundColor = UIColor( white: 0, alpha: 0.7 )
        actInd.frame = CGRect( x: 0, y: 0, width: 50, height: 50 )
        actInd.startAnimating()
        container.addSubview( actInd )
        container.addSubview( message )
        container.tag = 1000
        view.addSubview( container )
        actInd.startAnimating()
    }
    
    func hideLoader()
    {
        if let viewWithTag = self.view.viewWithTag(1000) {
            viewWithTag.removeFromSuperview()
        }
    }
}