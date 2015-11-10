//
//  AddCommentViewController.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 10/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class AddCommentViewController: UIViewController {

    @IBOutlet weak var commentField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        formatTextArea(commentField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
