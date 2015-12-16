//
//  LoginViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 05/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatInput(loginField)
        formatInput(passwordField)
        formatBtn(loginBtn)
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginBtnDidTouch(sender: AnyObject) {
        let login = loginField.text!
        let password = passwordField.text!
        
        if( login.isEmpty || password.isEmpty ) {
            let alertView = UIAlertController(title: "Informations manquantes", message: "Veuillez saisir votre login ET mot de passe", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertView.addAction(defaultAction)
            presentViewController(alertView, animated: true, completion: nil)
        } else {
            let requestBody = "login=\(login)&password=\(password)"
            let request = NSMutableURLRequest( URL: NSURL( string: "http://192.168.99.100/users/login" )! )
            request.HTTPMethod = "POST"
            request.HTTPBody = requestBody.dataUsingEncoding( NSUTF8StringEncoding )
            let task = NSURLSession.sharedSession().dataTaskWithRequest( request ) {
                results, response, error in
                
                if error != nil {
                    let alertView = UIAlertController( title: "Utilisateur introuvable", message: "Vos informations ne correspondent à aucun utilisateur", preferredStyle: .Alert )
                    let defaultAction = UIAlertAction( title: "Réessayer", style: .Default, handler: nil )
                    alertView.addAction(defaultAction)
                    self.presentViewController( alertView, animated: true, completion: nil )
                    print( error )
                    return
                }
                
                let data = JSON( data: results! )
                let user:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                user.setValue( data[ "data"][ "token" ].string, forKey: "USER_TOKEN")
                user.setValue( data[ "data" ][ "id" ].int, forKey: "USER_ID" )
                user.synchronize()
                
                dispatch_async(dispatch_get_main_queue()) {
                    let homeVC = self.storyboard?.instantiateViewControllerWithIdentifier( "foldersListScreen" )
                    self.navigationController?.pushViewController( homeVC!, animated: true )
                }
            }
            task.resume()
        }
    }

}
