//
//  RoundSignInButton.swift
//  devslopes-social
//
//  Created by Preston Grisham on 1/17/17.
//  Copyright © 2017 Preston Grisham. All rights reserved.
//

import UIKit

class RoundSignInButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 5

        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
        
    }
    
}
