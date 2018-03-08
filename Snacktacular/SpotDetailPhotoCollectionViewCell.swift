//
//  SpotDetailCollectionViewCell.swift
//  Snacktacular
//
//  Created by John Gallaugher on 3/5/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import UIKit

class SpotDetailPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!

    var photo: Photo! {
        didSet {
            if photoImageView.image != photo.image {
                photoImageView.image = photo.image
            }
        }
    }
}
