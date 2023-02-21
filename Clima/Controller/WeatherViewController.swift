//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTextField.placeholder = "Cari"
        
        // connect UITextField to UITextFieldDelegate
        searchTextField.delegate = self
        
        // connect to weatherManager delegate
        weatherManager.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        print(searchTextField.text!)
        
        //close keyboard when value is true
        searchTextField.endEditing(true)
    }
    /**
        UITextField delegate function, function is triggered when keyboard return button is pressed
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        
        //close keyboard when value is true
        searchTextField.endEditing(true)
        return true
    }
    
    
    /**
        UITextField delegate function, function is triggered to close the keyboard
      when the condition inside the function is fulfilled
     */
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "type something here..."
            return false
        }
    }
    
    /**
        UITextField delegate function, function is triggered when done editing the textField
     */
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // use searchTextField.text to get  the weather for that city.
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weather: WeatherModel) {
        print(weather.temperature)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

