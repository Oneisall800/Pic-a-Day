//
//  ClipboardCollectionViewCell.swift
//  sample-app
//
//  Created by Takudzwa Mhonde on 2018-10-31.
//  Copyright © 2018 Takudzwa Mhonde. All rights reserved.
//

import UIKit

class ClipboardCollectionViewCell: UICollectionViewCell {
   // @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet private weak var mainImage : UIImageView!
    
     @ IBOutlet weak var selectionImage: UIImageView!
     var isEditing: Bool = false {
         didSet {
         selectionImage.isHidden = !isEditing
         }
     }
    /*
    var image: ClipboardImage? {
        didSet {
            if let image = image {
                mainImage.image = UIImage(named: ClipboardImage.photo)
            }
        }
    }
     // remove any image being displayed when cell is recycled
     
     override func prepareForReuse() {
        mainImage.image = nil
     }
     
     */

     override var isSelected: Bool {
         didSet {
         selectionImage.image = isSelected ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
         }
     }
}


