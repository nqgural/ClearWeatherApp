//
//  ViewController.swift
//  Weather App
//
//  Created by MIKITA HURALIUK on 31.10.21.
//

import UIKit
import CoreLocation

final class TodayForecastViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    let weatherConditionImageView = UIView()
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
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        setupUI()
        locationButton.addTarget(self, action: #selector(self.locationButtonPressed(sender:)), for: .touchUpInside)
        locationManager.delegate = self
        weatherManager.delegate = self
        sendRequests()
    }
}

//MARK: - WeatherManagerDelegate
extension TodayForecastViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print(weather.temperature)
        DispatchQueue.main.async {
            self.addLayoutelements(withWeatherInfo: weather)
            self.temperatureLabel.text = weather.temperatureString
            self.weatherConditionImage.image = UIImage(systemName: weather.conditionImageName)
            self.cityLabel.text = weather.cityName
            self.conditionLabel.text = weather.conditionName
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Whoopss...", message: "We have some problems. Please, try agin later.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: - CLLocationManagerDelegate

extension TodayForecastViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            locationManager.stopUpdatingLocation()
            if let location = locations.last {
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
                weatherManager.fetchWeather(latitude: lat, longitude: lon)
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get users location.")
    }
}

// MARK: - Class methods
extension TodayForecastViewController {
    private func sendRequests() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @objc private func locationButtonPressed(sender: UIButton) {
        setupUI()

        for i in 0...4 {
            self.iconsArray[i].image = UIImage(systemName: "")
        }
        
        self.cityLabel.text = "Updating..."
        locationManager.requestLocation()
        buttonAnimation(sender: locationButton)
        
        print("BUTTON PRESSED!")
        NotificationCenter.default.post(name: Notification.Name("LocationButtonPressed"), object: nil)
    }
    
    private func buttonAnimation(sender: UIButton) {

        UIView.animate(withDuration: 0.1) {
            sender.layer.backgroundColor =  UIColor(named: "buttonColorHighlighted")?.cgColor
        }
        UIView.animate(withDuration: 0.2) {
            sender.layer.backgroundColor =  UIColor.link.cgColor
        }
    }
}

// MARK: - Autolayout
extension TodayForecastViewController {
    private func setupUI() {
        locationButton.backgroundColor = locationButton.isHighlighted ? UIColor.black : UIColor.white
        view.backgroundColor = UIColor(named: "appBackground")
        
        // MARK: - Weather Condition Image Constraints
        view.addSubview(weatherConditionImage)
        
        weatherConditionImage.tintColor = UIColor(named: "appBackground")
        weatherConditionImage.translatesAutoresizingMaskIntoConstraints = false
        weatherConditionImage.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        spinner.startAnimating()
        
        NSLayoutConstraint.activate([
            weatherConditionImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            weatherConditionImage.heightAnchor.constraint(equalTo: weatherConditionImage.widthAnchor),
            weatherConditionImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherConditionImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 25),
            spinner.centerYAnchor.constraint(equalTo: weatherConditionImage.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: weatherConditionImage.centerXAnchor)
        ])
        
        // MARK: - City Label Constraints
        
        view.addSubview(cityLabel)
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.textColor = UIColor(named: "appLabel")
        cityLabel.font = UIFont.boldSystemFont(ofSize: 30)
        cityLabel.textAlignment = NSTextAlignment.center
        cityLabel.text = "Data loading..."
        
        NSLayoutConstraint.activate([
            cityLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
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
        temperatureLabel.text = " "
        
        view.addSubview(conditionLabel)
        
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.textColor = .link
        conditionLabel.font = UIFont.systemFont(ofSize: 30)
        conditionLabel.textAlignment = NSTextAlignment.center
        conditionLabel.text = " "
        conditionLabel.numberOfLines = 1
        
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
            tempAndCondStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            temperatureLabel.widthAnchor.constraint(equalTo: tempAndCondStackView.widthAnchor, multiplier: 0.5),
            conditionLabel.widthAnchor.constraint(equalTo: tempAndCondStackView.widthAnchor, multiplier: 0.5)
        ])
        
        // MARK: - Icon + Label Stack Views
    
        for i in 0...4 {
            iconsArray.append(UIImageView(image: UIImage(systemName: "")))
            iconsArray[i].tintColor = UIColor(named: "appIcons")
            iconsArray[i].translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                iconsArray[i].widthAnchor.constraint(equalToConstant: 40),
                iconsArray[i].heightAnchor.constraint(equalTo: iconsArray[i].widthAnchor),
            ])
            
            labelsArray.append(UILabel())
            labelsArray[i].translatesAutoresizingMaskIntoConstraints = false
            labelsArray[i].textColor = UIColor(named: "appLabel")
            labelsArray[i].font = UIFont.systemFont(ofSize: 15)
            labelsArray[i].textAlignment = NSTextAlignment.center
            labelsArray[i].text = " "
            labelsArray[i].numberOfLines = 1
            
            NSLayoutConstraint.activate([
                labelsArray[i].widthAnchor.constraint(equalToConstant: 80),
            ])
            
            stackViewsArray.append(UIStackView())
            stackViewsArray[i].axis = .vertical
            stackViewsArray[i].spacing = 1
            stackViewsArray[i].alignment = .center // .Leading .FirstBaseline .Center .Trailing .LastBaseline
            stackViewsArray[i].distribution = .fillEqually // .FillEqually .FillProportionally .EqualSpacing .EqualCentering

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
            firstStackView.topAnchor.constraint(equalTo: tempAndCondStackView.bottomAnchor, constant: 30),
            firstStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
        for i in 0...2 {
            stackViewsArray[i].widthAnchor.constraint(equalTo: firstStackView.widthAnchor, multiplier: 0.3).isActive = true
        }
        
        // MARK: - Second StackView for icons
        
        secondStackView.axis = .horizontal
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
            secondStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
        ])
        for i in 3...4 {
            stackViewsArray[i].widthAnchor.constraint(equalTo: secondStackView.widthAnchor, multiplier: 0.39).isActive = true
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
            locationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
        
    }
    
    private func addLayoutelements(withWeatherInfo weather: WeatherModel) {
        self.iconsArray[0].image = UIImage(systemName: "face.dashed")
        self.iconsArray[1].image = UIImage(systemName: "cloud.rain")
        self.iconsArray[2].image = UIImage(systemName: "speedometer")
        self.iconsArray[3].image = UIImage(systemName: "wind")
        self.iconsArray[4].image = UIImage(systemName: "safari")
        
        self.spinner.stopAnimating()
        self.weatherConditionImage.tintColor = UIColor(named: "appIcons")
        
        self.labelsArray[0].text = weather.feelsLikeString
        self.labelsArray[1].text = weather.humidityString
        self.labelsArray[2].text = weather.pressureString
        self.labelsArray[3].text = weather.windSpeedString
        self.labelsArray[4].text = weather.windDirections
    }
}



