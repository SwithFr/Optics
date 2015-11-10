//
//  tools.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 10/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

let green = UIColor(red:0.75, green:0.89, blue:0.86, alpha:1.0)

func formatInput(input: UITextField) {
    input.backgroundColor = UIColor.clearColor()
    input.layer.borderWidth = 2
    input.layer.borderColor = green.CGColor
    input.layer.cornerRadius = CGFloat(5)
}

func formatBtn(btn: UIButton) {
    btn.layer.cornerRadius = CGFloat(20)
}

func formatRoundedImage(img: UIImageView, radius: CGFloat, color: UIColor, border: CGFloat) {
    img.layer.cornerRadius = radius
    img.layer.borderWidth = border
    img.layer.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).CGColor
    img.layer.borderColor = color.CGColor
    img.clipsToBounds = true
}

func formatTextArea(text: UITextView) {
    text.backgroundColor = UIColor.clearColor()
    text.layer.borderWidth = 2
    text.layer.borderColor = green.CGColor
    text.layer.cornerRadius = CGFloat(5)
    text.textColor = green
}