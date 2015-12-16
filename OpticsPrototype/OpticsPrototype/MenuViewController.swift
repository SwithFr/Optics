//
//  MenuViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 06/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func LogoutBtnDidTouch(sender: AnyObject)
    {
        let user:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        user.removeObjectForKey( "USER_ID" )
        user.removeObjectForKey( "USER_TOKEN" )
        
        let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier( "loginScreen" )
        self.navigationController?.pushViewController(loginVC!, animated: true)
    }

}
