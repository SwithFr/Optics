//
//  FolderDetailTableViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 05/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class FolderDetailTableViewController: UITableViewController {
    
    var currentFolder: NSDictionary = [String: String]()
    var pictures = [
        [ "author": "Swith", "time": "10 min", "comments": 18, "picture": "Ben.jpg" ],
        [ "author": "Void", "time": "24 min", "comments": 81, "picture": "Marion.jpg" ],
        [ "author": "Camille Caramel", "time": "2h", "comments": 13, "picture": "Ben.jpg" ]
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = currentFolder["name"] as? String
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("picture", forIndexPath: indexPath) as! FolderDetailTableViewCell
        let picture = pictures[indexPath.row]
        
        tableView.separatorColor = UIColor(red:0.75, green:0.89, blue:0.86, alpha:1.0)
        
        cell.author.text = picture["author"] as? String
        cell.time.text = picture["time"] as? String
        cell.commentsCount.text = String(picture["comments"]!)
        cell.picture.image = UIImage(named: picture["picture"] as! String)


        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pictureDetailSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let detailViewController = segue.destinationViewController as! PictureDetailViewController
            detailViewController.currentPicture = pictures[indexPath.row]
        }
    }


}
