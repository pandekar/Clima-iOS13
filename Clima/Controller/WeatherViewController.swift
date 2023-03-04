//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup location manager
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()

        // Do any additional setup after loading the view.
        searchTextField.placeholder = "Cari"
        
        // connect UITextField to UITextFieldDelegate
        searchTextField.delegate = self
        
        // connect to weatherManager delegate
        weatherManager.delegate = self
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.weatherCondition)
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.name
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR", error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let savedLocation = locations.last {
            let lat = savedLocation.coordinate.latitude
            let lon = savedLocation.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {

    @IBAction func searchPressed(_ sender: UIButton) {
        //close keyboard when value is true
        searchTextField.endEditing(true)
    }
    /**
        UITextField delegate function, function is triggered when keyboard return button is pressed
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
}
