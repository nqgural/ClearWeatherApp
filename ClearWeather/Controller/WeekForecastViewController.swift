//
//  WeekForecastViewController.swift
//  ClearWeather
//
//  Created by MIKITA HURALIUK on 30.10.21.
//

import UIKit
import CoreLocation

class WeekForecastViewController: UITableViewController {
    
    var weatherManager = HourlyWeatherManager()
    var locationManager = CLLocationManager()
    
    var section = [String]()

    var items = [[HourlyWeatherModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.registerTableViewCells()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self

    }
    
// MARK: - TABLE GENERATING
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "CustomTableViewCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell {

            cell.timeLabel.text = items[indexPath.section][indexPath.row].timeString
            cell.temperatureLabel.text = items[indexPath.section][indexPath.row].temperatureString
            cell.conditionLabel.text = items[indexPath.section][indexPath.row].conditionName
            cell.weatherConditionImage.image = UIImage(systemName: items[indexPath.section][indexPath.row].conditionImageName)
            
            return cell
          }
        return UITableViewCell()
    }

}

//MARK: - WeatherManagerDelegate
extension WeekForecastViewController: HourlyWeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: HourlyWeatherManager, weather: [HourlyList]) {
        DispatchQueue.main.async {
            self.fillSectionNames(from: weather)
            self.fillItemsData(from: weather)
            print(self.items.count)
            
            /*self.addLayoutelements(withWeatherInfo: weather)
            
            self.temperatureLabel.text = weather.temperatureString
            self.weatherConditionImage.image = UIImage(systemName: weather.conditionImageName)
            self.cityLabel.text = weather.cityName
            self.conditionLabel.text = weather.conditionName*/
            
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
    
extension WeekForecastViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            if let location = locations.last {
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
                weatherManager.fetchHourlyWeather(latitude: lat, longitude: lon)
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get users location.")
    }


}

// MARK: - DIFFERENT METHODS
extension WeekForecastViewController {
    func fillSectionNames(from weather: [HourlyList]) {
        section.removeAll()
        for i in 0...weather.count-1 {
            let weatherModel = HourlyWeatherModel(conditionId: weather[i].weather[0].id, temperature: weather[i].main.temp, date: weather[i].dt)
            
            section.append(weatherModel.weekDayString)
        }
        section = section.uniqued()
    }
    
    func fillItemsData(from weather: [HourlyList]) {
        var weatherModels = [HourlyWeatherModel]()
        for i in 0...weather.count-1 {
            let weatherModel = HourlyWeatherModel(conditionId: weather[i].weather[0].id, temperature: weather[i].main.temp, date: weather[i].dt)
            weatherModels.append(weatherModel)
        }
        
        for day in section {
            var dayArray = [HourlyWeatherModel]()
            for model in weatherModels {
                if day == model.weekDayString {
                    dayArray.append(model)
                }
            }
            print(dayArray)
            items.append(dayArray)
        }
    }
    
}



extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
