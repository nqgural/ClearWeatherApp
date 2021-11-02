//
//  HourlyWeatherManager.swift
//  ClearWeather
//


import Foundation
import CoreLocation

protocol HourlyWeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: HourlyWeatherManager, weather: [HourlyList])
    func didFailWithError(error: Error)
}

struct HourlyWeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?exclude=daily&units=metric&appid=882d566686f054834544c7b9dbeb43f6"
    
    var delegate: HourlyWeatherManagerDelegate?
    
    func fetchHourlyWeather(latitude lat: CLLocationDegrees, longitude lon: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1. Create URL
        if let url = URL(string: urlString) {
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            //3.Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4.Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ hourlyWeatherData: Data) -> [HourlyList]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodedData = try decoder.decode(HourlyWeatherData.self, from: hourlyWeatherData)
            let list = decodedData.list
            
                /*let date = decodedData.list[0].dt
            let temperature = decodedData.list[1].main.temp
            let conditionId = decodedData.list[2].weather[0].id
            let weather = HourlyWeatherModel(conditionId: conditionId, temperature: temperature, date: date)*/
            return list
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
