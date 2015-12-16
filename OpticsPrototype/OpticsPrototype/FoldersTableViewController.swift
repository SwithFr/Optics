//
//  FoldersTableViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 04/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class FoldersTableViewController: UITableViewController {
    
    @IBOutlet var eventIdField: UITextField?
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    var events:[JSON] = []
    
    override func viewWillAppear(animated: Bool) {
        getEvents()
    }
    
    private func getEvents() {
        let rc = RestCaller()
        rc.get( "events" , authenticate: true) {
            error, data in
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    print("error")
                }
                
                self.setAndReloadData( data )
            }
        }
    }
    
    private func addAndReloadData(data: NSData) {
        let events = JSON( data: data )
        self.events.append( events["data"] )
        self.tableView.reloadData()
    }
    
    private func setAndReloadData(data: NSData) {
        let events = JSON( data: data )
        self.events = events["data"].arrayValue
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("folderCell", forIndexPath: indexPath) as! FolderTableViewCell
        let event = events[ indexPath.row ]
        let date = convertDateFormater( event["created_at"].string! )
        
        tableView.separatorColor = green
        
        cell.name.text = event["title"].string
        cell.date.text = date
        //cell.picturesCount.text = String(folder["pictures"]!)
        cell.participantsCount.text = String( event["users_count"] )
        
        return cell
    }
    
    @IBAction func addBtnDidTouch(sender: AnyObject) {
        let popView = UIAlertController( title: "Ajouter un évènement", message: "Voulez vous créer un évènement ou en rejoindre un éxistant ?", preferredStyle: .Alert )
        
        let defaultAction = UIAlertAction( title: "Créer", style: .Default) {
            ( alert: UIAlertAction! ) in
                self.displayAddScreen()
        }
        
        let otherAction = UIAlertAction( title: "Rejoindre", style: .Default) {
            ( alert: UIAlertAction! ) in
                self.displayGetScreen()
        }
        
        let cancelAction = UIAlertAction( title: "Annuler", style: .Destructive, handler: nil )

        popView.addAction(defaultAction)
        popView.addAction(otherAction)
        popView.addAction(cancelAction)
        
        self.presentViewController( popView, animated: true, completion: nil )
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "folderDetailSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let detailViewController = segue.destinationViewController as! FolderDetailTableViewController
            
            detailViewController.currentEvent = events[ indexPath.row ]
        }
    }
    
    /*
     *   Show the add event screen
     */
    func displayAddScreen() {
        let addEventVC = self.storyboard?.instantiateViewControllerWithIdentifier( "addEventScreen" )
        self.navigationController?.pushViewController(addEventVC!, animated: true)
    }
    
    /*
     *   Add input in UIAlertView
     */
    func addTextField( textField: UITextField! ){
        textField.placeholder = "85171249"
        self.eventIdField = textField
    }
    
    /*
     *   Show the event join alert
     */
    func displayGetScreen() {
        
        let popView = UIAlertController( title: "Rejoindre un évènement", message: "Saisissez le code de l'évènement", preferredStyle: .Alert )
        
        let defaultAction = UIAlertAction( title: "Rejoindre", style: .Default) {
            ( alert: UIAlertAction! ) in
            let iEventID:NSString = (self.eventIdField?.text)!
            let rc = RestCaller()
            rc.get("events/join/\(iEventID)", authenticate: true) {
                error, data in
                dispatch_async(dispatch_get_main_queue()) {
                    self.addAndReloadData( data )
                }
            }
        }
        let cancelAction = UIAlertAction( title: "Annuler", style: .Destructive, handler: nil )
        
        popView.addTextFieldWithConfigurationHandler(addTextField)
        popView.addAction(defaultAction)
        popView.addAction(cancelAction)
        
        self.presentViewController( popView, animated: true, completion: nil )
    }

}
