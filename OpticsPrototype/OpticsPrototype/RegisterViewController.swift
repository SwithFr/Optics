//
//  RegisterViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 05/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatInput(loginField)
        formatInput(passwordField)
        formatInput(confirmField)
        formatBtn(registerBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RegisterBtnDidTouch(sender: AnyObject) {
        let login = loginField.text!
        let password = passwordField.text!
        let confirm = confirmField.text!
        
        if( login.isEmpty || password.isEmpty || confirm.isEmpty ) {
            let alertView = UIAlertController(title: "Informations manquantes", message: "Veuillez remplir tous les champs", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertView.addAction(defaultAction)
            presentViewController(alertView, animated: true, completion: nil)
        } else {
            
            if password != confirm {
                let alertView = UIAlertController(title: "Attention !", message: "Le mot de passe et la confirmation doivent être identiques", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alertView.addAction(defaultAction)
                presentViewController(alertView, animated: true, completion: nil)
                
            } else {
                
                let requestBody = "login=\(login)&password=\(password)"
                let request = NSMutableURLRequest( URL: NSURL( string: "http://192.168.99.100/users/register" )! )
                request.HTTPMethod = "POST"
                request.HTTPBody = requestBody.dataUsingEncoding( NSUTF8StringEncoding )
                let task = NSURLSession.sharedSession().dataTaskWithRequest( request ) {
                    data, response, error in
                    
                    if error != nil {
                        
                        let alertView = UIAlertController( title: "Désolé", message: "Ce login est déjà utiliser", preferredStyle: .Alert )
                        let defaultAction = UIAlertAction( title: "Choisir un autre login", style: .Default, handler: nil )
                        alertView.addAction(defaultAction)
                        self.presentViewController( alertView, animated: true, completion: nil )
                        print( error )
                        return
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        let homeVC = self.storyboard?.instantiateViewControllerWithIdentifier( "loginScreen" )
                        self.navigationController?.pushViewController( homeVC!, animated: true )
                    }
                }
                task.resume()
                
            }
        }
        

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
