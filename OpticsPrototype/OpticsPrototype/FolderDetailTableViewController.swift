//
//  FolderDetailTableViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 05/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class FolderDetailTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var currentFolder: NSDictionary = [String: String]()
    var currentEvent:JSON!
    var pictures = [
        [ "author": "Swith", "time": "10 min", "comments": 18, "picture": "Ben.jpg" ],
        [ "author": "Void", "time": "24 min", "comments": 81, "picture": "Marion.jpg" ],
        [ "author": "Camille Caramel", "time": "2h", "comments": 13, "picture": "Ben.jpg" ]
    ]

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = currentEvent[ "title" ].string
        self.navigationController?.setNavigationBarHidden( false, animated:true )
        
        let backImg = UIImage( named: "back-icon" )
        let backBtn = UIButton( type: .Custom )
        backBtn.addTarget( self, action: "popToRoot:", forControlEvents: UIControlEvents.TouchUpInside )
        backBtn.setImage( backImg, forState: .Normal )
        backBtn.sizeToFit()
        let backBtnItem = UIBarButtonItem( customView: backBtn )
        
        self.navigationItem.setLeftBarButtonItems( [ backBtnItem, menuBtn ], animated: true )
        self.navigationItem.backBarButtonItem = UIBarButtonItem( title:"", style:.Plain, target:nil, action:nil )
    }
    
    func popToRoot(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("picture", forIndexPath: indexPath) as! FolderDetailTableViewCell
        let picture = pictures[indexPath.row]
        
        tableView.separatorColor = green
        
        cell.author.text = picture["author"] as? String
        cell.time.text = picture["time"] as? String
        cell.commentsCount.text = String(picture["comments"]!)
        cell.picture.image = UIImage(named: picture["picture"] as! String)

        return cell
    }
    
    @IBAction func addPictureBtnDidTouch(sender: AnyObject) {
        let imageFromSource = UIImagePickerController()
        imageFromSource.delegate = self
        imageFromSource.allowsEditing = false
        
        if UIImagePickerController.isSourceTypeAvailable( UIImagePickerControllerSourceType.Camera ) {
            imageFromSource.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            imageFromSource.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        self.presentViewController( imageFromSource, animated: true, completion: nil )
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "pictureDetailSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let detailViewController = segue.destinationViewController as! PictureDetailViewController
            detailViewController.currentPicture = pictures[ indexPath.row ]
        } else if segue.identifier == "eventMenuSegue" {
            let eventMenuViewController = segue.destinationViewController as! EventMenuViewController
            eventMenuViewController.currentEvent = self.currentEvent
        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print( info )
    }


}
