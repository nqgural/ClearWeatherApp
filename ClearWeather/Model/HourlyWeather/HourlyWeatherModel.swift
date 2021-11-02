//
//  WeatherModelForFiveDays.swift
//  ClearWeather
//
//  Created by MIKITA HURALIUK on 1.11.21.
//

import Foundation

struct HourlyWeatherModel {
    let conditionId: Int
    let temperature: Double
    let date: TimeInterval
    
    
    var temperatureString: String {
        String(format: "%.0f", temperature) + "°"
    }
    
    var timeString: String {
        let time = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: time)
    }
    
    var weekDayString: String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    var conditionImageName: String {
        switch conditionId {
        case 200...300:
            return "cloud.bolt.rain"
        case 300...400:
            return "cloud.drizzle"
        case 500...600:
            return "cloud.rain"
        case 600...700:
            return "cloud.snow"
        case 700...799:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...900:
            return "cloud"
        default:
            return "questionmark.circle"
        }
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...300:
            return "Stormy"
        case 300...400:
            return "Drizzle"
        case 500...600:
            return "Rainy"
        case 600...700:
            return "Snooow"
        case 700...799:
            return "Foggy"
        case 800:
            return "Сlear"
        case 801...900:
            return "Cloudy"
        default:
            return "Whoops"
        }
        
        

    }

}
