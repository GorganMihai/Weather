//
//  WeatherData.swift
//  Weather
//
//  Created by Mihai Gorgan on 10.08.2022.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable{
    let temp: Double
}

struct Weather: Decodable{
    let id: Int
}

struct Model: Decodable {
    let time: String
    let image: String
    let temp: String
}
