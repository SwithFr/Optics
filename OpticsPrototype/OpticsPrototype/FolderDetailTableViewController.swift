//
//  FolderDetailTableViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 05/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit
import CoreMedia

class FolderDetailTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var currentFolder: NSDictionary = [String: String]()
    var currentEvent:JSON!
    var images:[JSON] = []
    var pictures = [
        [ "author": "Swith", "time": "10 min", "comments": 18, "picture": "Ben.jpg" ],
        [ "author": "Void", "time": "24 min", "comments": 81, "picture": "Marion.jpg" ],
        [ "author": "Camille Caramel", "time": "2h", "comments": 13, "picture": "Ben.jpg" ]
    ]

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = currentEvent[ "title" ].string
        self.navigationController?.setNavigationBarHidden( false, animated:true )
        
        let rc = RestCaller()
        rc.setParams( [ "eventid": String(currentEvent["id"].int!) ] )
        rc.get( "pictures" , authenticate: true) {
            error, data in
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    print("error")
                }
                
                self.setAndReloadData( data )
            }
        }
        
        let backImg = UIImage( named: "back-icon" )
        let backBtn = UIButton( type: .Custom )
        backBtn.addTarget( self, action: "popToRoot:", forControlEvents: UIControlEvents.TouchUpInside )
        backBtn.setImage( backImg, forState: .Normal )
        backBtn.sizeToFit()
        let backBtnItem = UIBarButtonItem( customView: backBtn )
        
        self.navigationItem.setLeftBarButtonItems( [ backBtnItem, menuBtn ], animated: true )
        self.navigationItem.backBarButtonItem = UIBarButtonItem( title:"", style:.Plain, target:nil, action:nil )
    }
    
    private func setAndReloadData(data: NSData) {
        let pictures = JSON( data: data )
        self.images = pictures["data"].arrayValue
        self.tableView.reloadData()
    }
    
    func popToRoot(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier( "picture", forIndexPath: indexPath ) as! FolderDetailTableViewCell
        let image = images[ indexPath.row ]
        let decodedData = NSData( base64EncodedString: String( image[ "image" ] ), options: NSDataBase64DecodingOptions( rawValue: 0 ) )
        let decodedimage = UIImage( data: decodedData! )
        cell.picture.image = decodedimage! as UIImage
        
        tableView.separatorColor = green
        
        cell.author.text = image[ "author" ].string
        cell.time.text = Date.ago( image[ "date" ].string! )
        cell.commentsCount.text = String( image[ "comments" ].int! )

        return cell
    }
    
    // Code get here https://www.hackingwithswift.com/read/13/3/importing-a-picture-uiimage
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
            detailViewController.currentPicture = images[ indexPath.row ]
        } else if segue.identifier == "eventMenuSegue" {
            let eventMenuViewController = segue.destinationViewController as! EventMenuViewController
            eventMenuViewController.currentEvent = self.currentEvent
        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        let rc = RestCaller()
        rc.uploadImage( String(currentEvent["id"].int!) ,image: img ) {
            error, data in
            if error != nil {
                print( "Error on upload" )
                return
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
