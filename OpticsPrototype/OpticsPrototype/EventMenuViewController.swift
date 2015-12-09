//
//  EventMenuViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 02/12/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class EventMenuViewController: UIViewController {
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var eventID: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionArea: UITextView!
    var currentEvent: JSON!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatTextArea( descriptionArea )
        self.navigationItem.title = currentEvent[ "title" ].string
        
        self.eventID.text = currentEvent[ "uuid" ].string
        
        if !currentEvent[ "description" ] {
            self.descriptionArea.hidden = true
            self.descriptionLabel.hidden = true
        } else {
            self.descriptionArea.text = currentEvent[ "description" ].string
        }
        
        if !User.isOwner( currentEvent[ "user_id" ] ) {
            deleteBtn.hidden = true
        } else {
            formatBtn( deleteBtn )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()    }
    
    @IBAction func deleteBtnDidTouch(sender: AnyObject) {
        let eventID = currentEvent[ "uuid" ].string!
        let rc = RestCaller()
        
        rc.delete( "events/\(eventID)", authenticate: true) {
            error, data in
            
            if error != nil {
                print("error on deletion")
                return
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                Navigator.goTo( "foldersListScreen" , vc: self)
            }
        }
    }

}
