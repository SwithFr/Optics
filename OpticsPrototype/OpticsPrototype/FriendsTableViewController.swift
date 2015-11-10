//
//  FriendsTableViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 06/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    var friends = [
        ["name": "Chokapik", "avatar": "fake.png"],
        ["name": "Bamboula", "avatar": "fake.png"],
        ["name": "Georgio Leonardo", "avatar": "fake.png"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath: indexPath) as! FriendTableViewCell
        
        let friend = friends[indexPath.row]
        
        tableView.separatorColor = UIColor(red:0.75, green:0.89, blue:0.86, alpha:1.0)
        
        let borderColor = UIColor(red:0.10, green:0.12, blue:0.16, alpha:1.0)
        formatRoundedImage(cell.friendAvatar, radius: 17.5, color: borderColor, border: 2)
        cell.friendAvatar.image = UIImage(named: friend["avatar"]! as String)
        cell.friendName.text = friend["name"]

        return cell
    }

}
