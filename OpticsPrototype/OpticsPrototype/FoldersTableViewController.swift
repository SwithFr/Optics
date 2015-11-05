//
//  FoldersTableViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 04/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class FoldersTableViewController: UITableViewController {
    
    var user = ""
    
    var folders = [
        [ "name": "Mon anniv", "date": "17/03/2015", "participants": 18, "pictures": 33 ],
        [ "name": "Soirée concert", "date": "23/12/2014", "participants": 81, "pictures": 93 ],
        [ "name": "Nam party", "date": "07/07/2015", "participants": 13, "pictures": 8 ]
    ]
    
    override func viewDidAppear(animated: Bool) {
        if user == "test" {
            performSegueWithIdentifier("loginSegue", sender: self)
        }
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("folderCell", forIndexPath: indexPath) as! FolderTableViewCell
        let folder = folders[indexPath.row]

        tableView.separatorColor = UIColor(red:0.75, green:0.89, blue:0.86, alpha:1.0)
        
        cell.name.text = folder["name"] as? String
        cell.date.text = folder["date"] as? String
        cell.picturesCount.text = String(folder["pictures"]!)
        cell.participantsCount.text = String(folder["participants"]!)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "folderDetailSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let detailViewController = segue.destinationViewController as! FolderDetailTableViewController
            detailViewController.currentFolder = folders[indexPath.row]
        }
    }

}
