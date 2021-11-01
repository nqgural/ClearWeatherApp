//
//  WeatherManager.swift
//  ClearWeather
//


import Foundation
import CoreLocation
import Network

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=882d566686f054834544c7b9dbeb43f6"
    let monitor = NWPathMonitor()
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeater(latitude lat: CLLocationDegrees, longitude lon: CLLocationDegrees) {
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
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temperature = decodedData.main.temp
            let feelsLike = decodedData.main.feelsLike
            let pressure = decodedData.main.pressure
            let humidity = decodedData.main.humidity
            let windSpeed = decodedData.wind.speed
            let windDegrees = decodedData.wind.deg
            
            let weather = WeatherModel(conditionId: id,
                                       cityName: name,
                                       temperature: temperature,
                                       feelsLike: feelsLike,
                                       windSpeed: windSpeed,
                                       pressure: pressure,
                                       humidity: humidity,
                                       deg: windDegrees)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
