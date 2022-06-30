//
//  DetailViewController.swift
//  TheCatApp
//
//  Created by isha pathak on 30/06/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var catDetailedImage = UIImage()
    var catName : String = ""
    
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var detailedImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false

        detailedImageView.image = catDetailedImage // display larger image
        catNameLabel.text = "I AM: \(catName)" // display cat id
    }
}
