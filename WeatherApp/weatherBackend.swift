//
//  weatherBackend.swift
//  WeatherApp
//
//  Created by Devanshu Kumar on 6/30/20.
//  Copyright © 2020 Devanshu Kumar. All rights reserved.
//

import Foundation

protocol tempreatureDelegate {
    func didUpdateWeather(temp: weatherInfo)
}

struct weatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=ae13574a1f19a995ed53b8d8dd950cf3&units=imperial"
    
    var delegate: tempreatureDelegate?
    
    func fetchWeather(cityName: String){
        var city = cityName
        city = (city as NSString).replacingOccurrences(of: " ", with: "+")
        let urlString = "\(weatherURL)&q=\(city)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                }
                
                if let safeData = data{
                    if let temp = self.parseJSON(weatherData: safeData){
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateWeather(temp: temp)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> weatherInfo?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let currTemp = decodedData.main.temp
            let maxTemp = decodedData.main.temp_max
            let minTemp = decodedData.main.temp_min
            let description = decodedData.weather[0].description
            
            let res = weatherInfo(temp: currTemp, description: description, max: maxTemp, min: minTemp)
            return res
        }catch{
            print(error)
            return nil
        }
    }
}
