//
//  MyCell.swift
//  RHPlaceholder
//
//  Created by Robert Herdzik on 03/03/2018.
//  Copyright © 2018 Robert Herdzik. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
   
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    private let placeholderMarker = RHPlaceholder()
    var dataLoaded = false {
        didSet {
            if dataLoaded {
                placeholderMarker.remove()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeholderMarker.register([label!, thumbnail!])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }

}
