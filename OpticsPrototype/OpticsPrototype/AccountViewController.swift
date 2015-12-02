//
//  AccountViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 06/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatInput(loginField)
        formatInput(passwordField)
        formatInput(confirmField)
        formatRoundedImage(avatar, radius: 50, color: green, border: 3)
        formatBtn(updateBtn)

    }
    
    override func viewDidAppear(animated: Bool) {
        let rc = RestCaller()
        rc.get( "users/settings", authenticate: true ) {
            error, data in
            
            if error != nil {
                print("error")
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                let user = JSON( data: data )
                self.loginField.text = user[ "data" ][ "login" ].string
            })
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateBtnDidTouch(sender: AnyObject) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
