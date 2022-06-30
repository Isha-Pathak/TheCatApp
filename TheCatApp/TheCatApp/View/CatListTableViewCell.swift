//
//  CatListTableViewCell.swift
//  TheCatApp
//
//  Created by isha pathak on 30/06/22.
//

import UIKit

class CatListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewCell.layer.borderWidth = 1
        imageViewCell.layer.masksToBounds = false
        imageViewCell.layer.borderColor = UIColor.darkGray.cgColor
      //  imageViewCell.layer.cornerRadius = imageViewCell.frame.width/2
        imageViewCell.clipsToBounds = true
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: set function to set the image to imageview
    func set(cat:Cat) {
        ImageService.getImage(withURL: cat.url) { image in
            self.imageViewCell.image = image
        }
    }
    
    
}

