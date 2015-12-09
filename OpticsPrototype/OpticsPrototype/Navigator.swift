//
//  Navigator.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 02/12/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import Foundation
import UIKit

class Navigator {
    
    static func goTo(viewControllerId: String, vc: UIViewController)
    {
        let targetVC = vc.storyboard?.instantiateViewControllerWithIdentifier( viewControllerId )
        vc.navigationController?.pushViewController( targetVC!, animated: true )
    }
    
    static func closeModal(vc: UIViewController)
    {
        vc.dismissViewControllerAnimated(true, completion: nil)
    }
    
}