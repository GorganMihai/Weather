//
//  MyCollectionViewCell.swift
//  Weather
//
//  Created by Mihai Gorgan on 16.08.2022.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var dayLabel: UILabel!
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

    private func setImage(_ imageName: String) -> UIImage{
        return UIImage(systemName: imageName)!
    }
    
    public func configure(with model: WeatherModel){
        self.timeLabel.text = model.time
        self.image.image = setImage(model.image)
        self.tempLabel.text = model.temp
        self.dayLabel.text = model.weekDay
    }
    
    
    
    
}

