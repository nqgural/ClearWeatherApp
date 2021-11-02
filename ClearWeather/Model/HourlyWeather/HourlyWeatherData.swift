//
//  WeatherDataForFiveDays.swift
//  ClearWeather
//
//  Created by MIKITA HURALIUK on 1.11.21.
//

import Foundation

struct HourlyWeatherData: Codable {
    let list: [HourlyList]
}

struct HourlyList: Codable {
    let dt: TimeInterval
    let main: HourlyMain
    let weather: [HourlyWeather]
}

struct HourlyMain: Codable {
    let temp: Double
}

struct HourlyWeather: Codable {
    let id: Int
    let main: String
}
