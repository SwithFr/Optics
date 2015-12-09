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
    let BorderColor = UIColor(red:0.10, green:0.12, blue:0.16, alpha:1.0)
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var authorPictureAvatar: UIImageView!
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let decodedData = NSData(base64EncodedString: String(currentPicture["image"]), options: NSDataBase64DecodingOptions(rawValue: 0))
        let decodedimage = UIImage(data: decodedData!)
        
        picture.image = decodedimage! as UIImage
        author.text = currentPicture["author"].string
        time.text = Date.ago(currentPicture["date"].string!)
        commentsCount.text = String(currentPicture["comments"].int!)
        formatRoundedImage(authorPictureAvatar, radius: 20, color: BorderColor, border: 1.5)
        //authorPictureAvatar.image = UIImage(named: "moi.png")
        authorPictureAvatar.image = getImageFromUrl(currentPicture["avatar"].string!)
        
        if !User.isOwner(currentPicture[ "user_id" ]) {
            self.navigationItem.rightBarButtonItem = nil
        }
        //self.navigationItem.title = currentPicture["title"].string
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var comments = [
        ["author": "Daniel", "comment": "Un super commentaire", "authorAvatar": "fake.png"],
        ["author": "Delphine", "comment": "Un super commentaire", "authorAvatar": "fake.png"],
        ["author": "Adrien", "comment": "Grillades !", "authorAvatar": "fake.png"]
    ]
    
    @IBAction func deleteBtnDidTouch(sender: AnyObject) {
        let popView = UIAlertController( title: "Supprimer cette photo", message: "Voulez vous vraiment supprimer cette photo ?", preferredStyle: .Alert )
        
        let defaultAction = UIAlertAction( title: "Supprimer", style: .Destructive) {
            ( alert: UIAlertAction! ) in
            Picture.delete( String(self.currentPicture[ "id" ]) ) {
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
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! CommentTableViewCell
        let comment = comments[indexPath.row]
        
        tableView.separatorColor = UIColor(red:0, green:0, blue:0, alpha:0)
        
        cell.author.text = comment["author"]! as String
        cell.comment.text = comment["comment"]! as String
        formatRoundedImage(cell.authorAvatar, radius: 20, color: BorderColor, border: 1.5)
        cell.authorAvatar.image = UIImage(named: comment["authorAvatar"]! as String)
        
        return cell
        
    }
}
