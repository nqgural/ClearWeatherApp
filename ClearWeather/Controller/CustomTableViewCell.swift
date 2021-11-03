//
//  CustomTableViewCell.swift
//  ClearWeather
//
//  Created by MIKITA HURALIUK on 1.11.21.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {

    let weatherConditionImage = UIImageView(image: UIImage(systemName: "sun.max"))
    let timeLabel = UILabel()
    let conditionLabel = UILabel()
    let temperatureLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}


// MARK: - Autolayout
extension CustomTableViewCell {
    private func setupUI() {
        
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
        
        contentView.addSubview(timeLabel)
        
        timeLabel.textColor = UIColor(named: "appLabel")
        timeLabel.text = "00:00"
        timeLabel.font = UIFont.systemFont(ofSize: 25)
        timeLabel.textAlignment = NSTextAlignment.left
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            timeLabel.heightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            timeLabel.leftAnchor.constraint(equalTo: weatherConditionImage.rightAnchor, constant: 20),
            timeLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 15)
            ])
        
        contentView.addSubview(conditionLabel)
        
        conditionLabel.textColor = UIColor(named: "appLabel")
        conditionLabel.text = "Clear"
        conditionLabel.font = UIFont.systemFont(ofSize: 19, weight: .light)
        conditionLabel.textAlignment = NSTextAlignment.left
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conditionLabel.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            conditionLabel.heightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            conditionLabel.leftAnchor.constraint(equalTo: weatherConditionImage.rightAnchor, constant: 20),
            conditionLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5)
            ])
        
        contentView.addSubview(temperatureLabel)
        
        temperatureLabel.textColor = UIColor.link
        temperatureLabel.text = "0°"
        temperatureLabel.font = UIFont.systemFont(ofSize: 35, weight: .light)
        temperatureLabel.textAlignment = NSTextAlignment.right
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            temperatureLabel.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            temperatureLabel.heightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
            temperatureLabel.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -25),
            temperatureLabel.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor)
            ])
    }
    
}
