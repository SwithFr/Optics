//
//  PictureDetailViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 05/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class PictureDetailViewController: UIViewController, UITableViewDataSource {
    
    var currentPicture: JSON!
    var comments: [JSON] = []
    
    @IBOutlet weak var addCommentBtn: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var authorPictureAvatar: UIImageView!
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let decodedData = NSData( base64EncodedString: String( currentPicture[ "image" ] ), options: NSDataBase64DecodingOptions( rawValue: 0 ) )
        let decodedimage = UIImage( data: decodedData! )
        
        picture.image = decodedimage! as UIImage
        author.text = currentPicture[ "author" ].string
        time.text = Date.ago( currentPicture[ "date" ].string! )
        
        formatBtn( addCommentBtn )
        formatRoundedImage(authorPictureAvatar, radius: 20, color: black, border: 1.5)
        authorPictureAvatar.image = getImageFromUrl( currentPicture[ "avatar" ].string! )
        
        if !User.isOwner( currentPicture[ "user_id" ] ) {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    
    override func viewDidAppear(animated: Bool) {
        showLoader( "Chargement" )
        let rc = RestCaller()
        rc.setParams( [ "pictureid": String( currentPicture[ "id" ] ) ] )
        rc.get( "comments", authenticate: true) {
            error, data in
            
            if error != nil {
                print( "Error when getting comments" )
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.hideLoader()
                self.setAndReloadData( data )
            }
        }
    }
    
    func setAndReloadData(data: NSData) {
        let coms = JSON( data: data )
        self.comments = coms[ "data" ].arrayValue
        self.myTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func deleteBtnDidTouch(sender: AnyObject) {
        let popView = UIAlertController( title: "Supprimer cette photo", message: "Voulez vous vraiment supprimer cette photo ?", preferredStyle: .Alert )
        
        let defaultAction = UIAlertAction( title: "Supprimer", style: .Destructive) {
            ( alert: UIAlertAction! ) in
            Picture.delete( String(self.currentPicture[ "id" ] ) ) {
                Navigator.goBack( self )
            }
        }
        
        popView.addAction(defaultAction)
        self.presentViewController( popView, animated: true, completion: nil )
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier( "commentCell", forIndexPath: indexPath ) as! CommentTableViewCell
        let comment = comments[ indexPath.row ]
        
        tableView.separatorColor = grey
        
        cell.author.text = comment[ "author" ].string
        cell.comment.text = comment[ "comment" ].string
        formatRoundedImage( cell.authorAvatar, radius: 20, color: black, border: 1.5 )
        cell.authorAvatar.image = getImageFromUrl( String( comment[ "avatar" ] ) )
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addCommentSegue" {
            let commentViewController = segue.destinationViewController as! AddCommentViewController
            commentViewController.sPictureid = String( currentPicture[ "id" ] )
            commentViewController.sEventId = currentPicture[ "event_id" ].string
        }
    }
}
