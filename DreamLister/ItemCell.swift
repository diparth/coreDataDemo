//
//  ItemCell.swift
//  DreamLister
//
//  Created by Diparth Patel on 5/30/17.
//  Copyright © 2017 Diparth Patel. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDetails: UITextView!
    
    func configureCell(item: Item) {
        
        itemTitle.text = item.title
        itemPrice.text = "$\(item.price)"
        itemDetails.text = item.details
        if item.toImage != nil {
            itemImage.image = item.toImage?.image as? UIImage
        }
    }
    
}



