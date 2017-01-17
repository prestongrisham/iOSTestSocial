//
//  LoginTextFields.swift
//  devslopes-social
//
//  Created by Preston Grisham on 1/17/17.
//  Copyright © 2017 Preston Grisham. All rights reserved.
//

import UIKit

class LoginTextFields: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor.orange.cgColor
        layer.borderWidth = 1.0
        
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
}
