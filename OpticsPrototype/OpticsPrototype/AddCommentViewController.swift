//
//  AddCommentViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 10/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class AddCommentViewController: UIViewController {

    @IBOutlet weak var charactersLimitLabel: UILabel!
    @IBOutlet weak var commentField: UITextView!
    var sPictureid: String!
    var sEventId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatTextArea(commentField)
        self.navigationItem.backBarButtonItem = UIBarButtonItem( title:"", style:.Plain, target:nil, action:nil )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addCommentBtnDidTouch(sender: AnyObject) {
        
        let comment = commentField.text
        
        if comment.isEmpty {
            let alertView = UIAlertController(title: "Informations manquantes", message: "Veuillez saisir un commentaire", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertView.addAction(defaultAction)
            presentViewController(alertView, animated: true, completion: nil)

        }
        
        if comment.characters.count > 80 {
            
            let alertView = UIAlertController(title: "Commentaire trop long", message: "Veuillez saisir un commentaire de maximum 80 caractères", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertView.addAction(defaultAction)
            
            charactersLimitLabel.textColor = red
            
            presentViewController(alertView, animated: true, completion: nil)
            
        } else {
            
            Comment.add( commentField.text, pictureid: sPictureid, eventid: sEventId ) {
                data in
                    dispatch_async(dispatch_get_main_queue()) {
                        Navigator.goBack( self )
                    }
            }
            
        }
    }
}
