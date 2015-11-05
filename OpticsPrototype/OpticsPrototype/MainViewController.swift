//
//  MainViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 04/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController {

    override func viewDidAppear(animated: Bool) {
        let user = ""
            
        if user == "test" {
            performSegueWithIdentifier("loginSegue", sender: self)
        } else {
            performSegueWithIdentifier("foldersListSegue", sender: self)
        }
    }

}
