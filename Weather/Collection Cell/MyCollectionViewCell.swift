//
//  MyCollectionViewCell.swift
//  Weather
//
//  Created by Mihai Gorgan on 16.08.2022.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    
    static let identifier = "MyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    private func setImage() -> UIImage{
        return UIImage(systemName: "sun.max.circle")!
    }
    
    public func configure(with model: Model){
        self.timeLabel.text = model.time
        self.image.image = setImage()
        self.tempLabel.text = model.temp
    }
    
    
    
    
}

