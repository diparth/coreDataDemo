//
//  MaterialView.swift
//  DreamLister
//
//  Created by Diparth Patel on 5/30/17.
//  Copyright © 2017 Diparth Patel. All rights reserved.
//

import UIKit

private var materialKey = false


extension UIView {
    
    @IBInspectable var materialDesign: Bool {
    
        get {
            return materialKey
        }
        
        set {
            materialKey = newValue
            
            if materialKey {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize.init(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor.darkGray.cgColor
            } else {
                self.layer.cornerRadius = 0
                self.layer.shadowColor = nil
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
            }
        }
        
    }
    
}



