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

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        formatTextArea( descriptionArea )
        self.navigationItem.title = currentEvent[ "title" ].string
        
        self.eventID.text = currentEvent[ "uuid" ].string
        
        if currentEvent[ "description" ] != "" {
            self.descriptionArea.text = String( currentEvent[ "description" ] )
        } else {
            self.descriptionArea.hidden = true
            self.descriptionLabel.hidden = true
        }
        
        if !User.isOwner( currentEvent[ "user_id" ] ) {
            deleteBtn.hidden = true
        } else {
            formatBtn( deleteBtn )
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func shareBtnDidTouch(sender: AnyObject)
    {
        let shareVC = UIActivityViewController( activityItems: [ eventID.text! ], applicationActivities: nil )
        presentViewController( shareVC, animated: true, completion: nil )
    }
    
    @IBAction func deleteBtnDidTouch(sender: AnyObject)
    {
        let popView = UIAlertController( title: "Supprimer cet évènement", message: "Voulez vous vraiment supprimer cet évènement ?", preferredStyle: .Alert )
        
        let defaultAction = UIAlertAction( title: "Supprimer", style: .Destructive) {
            ( alert: UIAlertAction! ) in
            Event.delete( self.currentEvent[ "uuid" ].string! ) {
                Void in
                
                dispatch_async( dispatch_get_main_queue() ) {
                    Navigator.goTo( "foldersListScreen" , vc: self )
                }
            }
        }
        
        popView.addAction(defaultAction)
        self.presentViewController( popView, animated: true, completion: nil )
        
    }

}
