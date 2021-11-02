//
//  WeatherModel.swift
//  ClearWeather
//



import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let feelsLike: Double
    let windSpeed: Double
    let pressure: Int
    let humidity: Int
    let deg: Int
    
    var feelsLikeString: String {
        String(format: "%.1f", feelsLike) + "°C"
    }
    var windSpeedString: String {
        String(format: "%.1f", windSpeed) + " km/h"
    }
    var pressureString: String {
        String(pressure) + " pHa"
    }
    var humidityString: String {
        String(humidity) + "%"
    }
    
    var windDirections: String {
        switch deg {
        case 0..<25:
            return "N"
        case 25..<65:
            return "NE"
        case 65..<115:
            return "E"
        case 115..<155:
            return "SE"
        case 125..<205:
            return "S"
        case 205..<245:
            return "SW"
        case 245..<295:
            return "W"
        case 295..<335:
            return "NW"
        case 335...360:
            return "N"
        default:
            return "Failed"
        }
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
    
    var temperatureString: String {
        String(format: "%.1f", temperature) + " °C"
    }

}
