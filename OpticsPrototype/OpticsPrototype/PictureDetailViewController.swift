//
//  PictureDetailViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 05/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class PictureDetailViewController: UIViewController, UITableViewDataSource {
    
    var currentPicture: NSDictionary = [String: String]()
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var authorPictureAvatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picture.image = UIImage(named: currentPicture["picture"] as! String)
        author.text = currentPicture["author"] as? String
        time.text = currentPicture["time"] as? String
        commentsCount.text = String(currentPicture["comments"]!)
        authorPictureAvatar.layer.cornerRadius = CGFloat(20)
        authorPictureAvatar.layer.borderWidth = 1.5
        authorPictureAvatar.layer.borderColor = UIColor(red:0.10, green:0.12, blue:0.16, alpha:1.0).CGColor
        authorPictureAvatar.clipsToBounds = true
        authorPictureAvatar.image = UIImage(named: "moi.png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var comments = [
        ["author": "Daniel", "comment": "Un super commentaire", "authorAvatar": "fake.png"],
        ["author": "Delphine", "comment": "Un super commentaire", "authorAvatar": "fake.png"],
        ["author": "Adrien", "comment": "Grillades !", "authorAvatar": "fake.png"]
    ]
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! CommentTableViewCell
        let comment = comments[indexPath.row]
        
        tableView.separatorColor = UIColor(red:0, green:0, blue:0, alpha:0)
        
        cell.author.text = comment["author"]! as String
        cell.comment.text = comment["comment"]! as String
        cell.authorAvatar.layer.cornerRadius = CGFloat(20)
        cell.authorAvatar.layer.borderWidth = 1.5
        cell.authorAvatar.layer.borderColor = UIColor(red:0.10, green:0.12, blue:0.16, alpha:1.0).CGColor
        cell.authorAvatar.clipsToBounds = true
        cell.authorAvatar.image = UIImage(named: comment["authorAvatar"]! as String)
        
        return cell
        
    }
}
