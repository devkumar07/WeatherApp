//
//  ViewController.swift
//  WeatherApp
//
//  Created by Devanshu Kumar on 6/30/20.
//  Copyright © 2020 Devanshu Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, tempreatureDelegate{

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var weatherLabel: UILabel!
    var weather = weatherManager()
    
    var cityName: String = ""
    var temp: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextField.delegate = self
        weather.delegate = self

        // Do any additional setup after loading the view.
    }
    @IBAction func searchButton(_ sender: AnyObject) {
        cityTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityTextField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = cityTextField.text{
            cityName = city
            weather.fetchWeather(cityName: city)
        }
        cityTextField.text = ""
    }
    
    func didUpdateWeather(temp: weatherInfo){
        weatherLabel.text = "The tempreature in \(cityName) is \(String(temp.temp)) degrees with \(temp.description). The max today will be \(String(temp.max)) degrees and low will be \(temp.min)"
        weatherLabel.isHidden = false
    }
}

