//
//  BookmarkedCellView.swift
//  Weathered
//
//  Created by Michael Amiro on 06/11/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class BookmarkedLocationsCell: UICollectionViewCell {
    static let reuseIdentifier = "locationCell"
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var deleteIcon: UIImageView!
    
    var isEditing: Bool = false {
        didSet{
            deleteIcon.isHidden = !isEditing
        }
    }
    override var isSelected: Bool {
        didSet {
            if isEditing {
                deleteIcon.image = isSelected ? UIImage(named: "checkmark-filled") : UIImage(named: "checkmark-free")
            }
        }
    }
}
