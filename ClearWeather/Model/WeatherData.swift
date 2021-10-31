//
//  WeatherData.swift
//  ClearWeather
//


import Foundation

struct WeatherData: Codable {
    let name: String
    let id: Int
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Weather: Codable {
    let id: Int
}
