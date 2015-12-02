//
//  AddEventViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 30/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var createBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatInput( titleField )
        formatTextArea( descriptionField )
        formatBtn( createBtn )
        
        
    }
    
    @IBAction func createBtnDidTouch(sender: AnyObject) {
        let title = trim( titleField.text! )
        let description = trim( descriptionField.text )
        
        if title == "" || description == "" {
            print( "Error" )
        } else {
            let rc = RestCaller()
            rc.setData( "title=\(title)&description=\(description)" )
            rc.post( "events/create", authenticate: true ) {
                error, data in
                
                if error != nil {
                    print("error")
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    let eventListVC = self.storyboard?.instantiateViewControllerWithIdentifier( "foldersListScreen" )
                    self.navigationController!.pushViewController( eventListVC!, animated: true )
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
