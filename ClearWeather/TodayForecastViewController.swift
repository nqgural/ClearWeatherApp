//
//  ViewController.swift
//  Weather App
//
//  Created by MIKITA HURALIUK on 31.10.21.
//

import UIKit

class TodayForecastViewController: UIViewController {

    let weatherConditionImage = UIImageView(image: UIImage(systemName: "sun.max"))
    let cityLabel = UILabel()
    let temperatureLabel = UILabel()
    let conditionLabel = UILabel()
    let tempAndCondStackView = UIStackView()
    let locationButton = UIButton()
    
    var iconsArray: [UIImageView] = []
    var labelsArray: [UILabel] = []
    var stackViewsArray: [UIStackView] = []
    
    let firstStackView = UIStackView()
    let secondStackView = UIStackView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        setupUI()
        
        
        
    }


}

extension TodayForecastViewController {
    private func setupUI() {
        view.backgroundColor = UIColor(named: "appBackground")
        
        // MARK: - Weather Condition Image Constraints
        
        view.addSubview(weatherConditionImage)
        
        weatherConditionImage.tintColor = UIColor(named: "appIcons")
        weatherConditionImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherConditionImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            weatherConditionImage.heightAnchor.constraint(equalTo: weatherConditionImage.widthAnchor),
            weatherConditionImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherConditionImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 25)
        ])
        
        // MARK: - City Label Constraints
        
        view.addSubview(cityLabel)
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.textColor = UIColor(named: "appLabel")
        cityLabel.font = UIFont.boldSystemFont(ofSize: 30)
        cityLabel.textAlignment = NSTextAlignment.center
        cityLabel.text = "Minsk"
        
        NSLayoutConstraint.activate([
            cityLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            cityLabel.heightAnchor.constraint(equalTo: cityLabel.widthAnchor, multiplier: 0.2),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: weatherConditionImage.bottomAnchor, constant: 3),
        ])
        
        // MARK: - Condition and Temperature Labels in StackView
        
        view.addSubview(temperatureLabel)
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.textColor = .link
        temperatureLabel.font = UIFont.systemFont(ofSize: 30)
        temperatureLabel.textAlignment = NSTextAlignment.center
        temperatureLabel.text = "12.9°C"
        
        view.addSubview(conditionLabel)
        
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.textColor = .link
        conditionLabel.font = UIFont.systemFont(ofSize: 30)
        conditionLabel.textAlignment = NSTextAlignment.center
        conditionLabel.text = "Sunny"
        conditionLabel.numberOfLines = 2
        
        tempAndCondStackView.axis = .horizontal

        tempAndCondStackView.alignment = .fill // .Leading .FirstBaseline .Center .Trailing .LastBaseline
        tempAndCondStackView.distribution = .fill // .FillEqually .FillProportionally .EqualSpacing .EqualCentering

        tempAndCondStackView.addArrangedSubview(temperatureLabel)
        tempAndCondStackView.addArrangedSubview(conditionLabel)

        view.addSubview(tempAndCondStackView)
        tempAndCondStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tempAndCondStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempAndCondStackView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            tempAndCondStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            temperatureLabel.widthAnchor.constraint(equalTo: tempAndCondStackView.widthAnchor, multiplier: 0.5),
            conditionLabel.widthAnchor.constraint(equalTo: tempAndCondStackView.widthAnchor, multiplier: 0.5)
        ])
        
        // MARK: - Icon + Label Stack Views
    
        for i in 0...4 {
            
            iconsArray.append(UIImageView(image: UIImage(systemName: "cloud.rain")))
            iconsArray[i].tintColor = UIColor(named: "appIcons")
            iconsArray[i].translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                iconsArray[i].widthAnchor.constraint(equalToConstant: 50),
                iconsArray[i].heightAnchor.constraint(equalTo: iconsArray[i].widthAnchor),
            ])
            
            labelsArray.append(UILabel())
            labelsArray[i].translatesAutoresizingMaskIntoConstraints = false
            labelsArray[i].textColor = UIColor(named: "appLabel")
            labelsArray[i].font = UIFont.systemFont(ofSize: 15)
            labelsArray[i].textAlignment = NSTextAlignment.center
            labelsArray[i].text = "1019 pHa"
            labelsArray[i].numberOfLines = 1
            
            NSLayoutConstraint.activate([
                labelsArray[i].widthAnchor.constraint(equalToConstant: 80),
            ])
            
            stackViewsArray.append(UIStackView())
            stackViewsArray[i].axis = .vertical
            stackViewsArray[i].alignment = .center // .Leading .FirstBaseline .Center .Trailing .LastBaseline
            stackViewsArray[i].distribution = .fill // .FillEqually .FillProportionally .EqualSpacing .EqualCentering

            stackViewsArray[i].addArrangedSubview(iconsArray[i])
            stackViewsArray[i].addArrangedSubview(labelsArray[i])

            view.addSubview(stackViewsArray[i])
            stackViewsArray[i].translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                stackViewsArray[i].heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
                stackViewsArray[i].widthAnchor.constraint(equalToConstant: 80)
            ])
            
        }
        
        // MARK: - First StackView for icons
        
        firstStackView.axis = .horizontal

        firstStackView.alignment = .center // .Leading .FirstBaseline .Center .Trailing .LastBaseline
        firstStackView.distribution = .equalSpacing // .FillEqually .FillProportionally .EqualSpacing .EqualCentering

        for i in 0...2 {
            firstStackView.addArrangedSubview(stackViewsArray[i])
        }
        
        view.addSubview(firstStackView)
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstStackView.topAnchor.constraint(equalTo: tempAndCondStackView.bottomAnchor, constant: 40),
            firstStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
        for i in 0...2 {
            stackViewsArray[i].widthAnchor.constraint(equalTo: firstStackView.widthAnchor, multiplier: 0.35).isActive = true
        }
        
        // MARK: - Second StackView for icons
        
        secondStackView.axis = .horizontal
        secondStackView.spacing = 10
        secondStackView.alignment = .center // .Leading .FirstBaseline .Center .Trailing .LastBaseline
        secondStackView.distribution = .fill // .FillEqually .FillProportionally .EqualSpacing .EqualCentering

        for i in 3...4 {
            secondStackView.addArrangedSubview(stackViewsArray[i])
        }
        
        view.addSubview(secondStackView)
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondStackView.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 10),
            secondStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
        ])
        for i in 3...4 {
            stackViewsArray[i].widthAnchor.constraint(equalTo: secondStackView.widthAnchor, multiplier: 0.35).isActive = true
        }
        
        // MARK: - Location Button
        
        view.addSubview(locationButton)
        
        locationButton.backgroundColor = .link
        locationButton.setTitle("Update Location" , for: .normal)
        locationButton.setImage(UIImage(named: "location.fill"), for: .normal)
        locationButton.layer.cornerRadius = 20
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            locationButton.heightAnchor.constraint(equalToConstant: 45),
            locationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
    }
}
