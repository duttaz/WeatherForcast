//
//  TempDetailCollectionViewCell.swift
//  WeatherForecast
//
//  Created by 3EMBED on 18/08/21.
//

import UIKit

class TempDetailCollectionViewCell: UICollectionViewCell {
     //MARK:- LifeCycle
    let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        descriptionLabel.text = ""
        descriptionLabel.textAlignment = .center

        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     
    func  updateData(text:String)  {
        self.descriptionLabel.text = text
        print(self.descriptionLabel)
    }
    
}
