//
//  CustomTableViewCell.swift
//  ClearWeather
//
//  Created by MIKITA HURALIUK on 1.11.21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    let weatherConditionImage = UIImageView(image: UIImage(systemName: "sun.max"))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}


extension CustomTableViewCell {
    func setupUI() {
        // MARK: - ???
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        contentView.addSubview(weatherConditionImage)
        
        weatherConditionImage.tintColor = UIColor(named: "appIcons")
        weatherConditionImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherConditionImage.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.1),
            weatherConditionImage.heightAnchor.constraint(equalTo: weatherConditionImage.widthAnchor),
            weatherConditionImage.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 25),
            weatherConditionImage.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor)
            ])
    }
    
}
