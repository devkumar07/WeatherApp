//
//  weatherData.swift
//  WeatherApp
//
//  Created by Devanshu Kumar on 6/30/20.
//  Copyright © 2020 Devanshu Kumar. All rights reserved.
//

import Foundation


struct WeatherData:Decodable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main:Decodable{
    let temp: Double
    let temp_max: Double
    let temp_min: Double
}

struct Weather:Decodable{
    let description: String
}

struct weatherInfo {
    let temp: Double
    let description: String
    let max: Double
    let min: Double
}
