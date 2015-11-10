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
        let user = "logged"
            
        if user == "" {
            print("notLogged")
            let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("loginScreen")
            pushViewController(loginVC!, animated: true)
        }
    }

}
