//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Eric on 17.12.2019.
//  Copyright © 2019 Eric Grant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var aparentTemperatureLabel: UILabel!
    
    @IBOutlet var refreshButton: UIButton!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // Проверка индикатора на вкл/выкл
    func toggleActivityIndicator(on: Bool) {
        refreshButton.isHidden = on
        
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    lazy var weatherManager = APIWeatherManager(apiKey: "a519b95ff28a237ec3c1eedd4a032683")
    let coordinates = Coordinates(latitude: 55.030474, longitude: 82.924474)

    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentWeatherData()
         
    }
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        toggleActivityIndicator(on: true)
        getCurrentWeatherData()
    }
    
    func getCurrentWeatherData() {
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
            self.toggleActivityIndicator(on: false)
            switch result {
            case .Success(let currentWeather):
                self.updateUIWith(currentWeather: currentWeather)
            case .Failure(let error as NSError):
                
                let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

// Метод изменяющий интерфейс погоды
    func updateUIWith(currentWeather: CurrentWeather) {
        
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.humidityLabel.text = currentWeather.humidityString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.aparentTemperatureLabel.text = currentWeather.aparentTemperatureString
        
    }
}
