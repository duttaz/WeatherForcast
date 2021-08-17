//
//  cityVM.swift
//  WeatherForecast
//
//  Created by dattaphani on 14/08/21.
//

import UIKit
import MapKit

class cityVM: NSObject {

    var cityweather:CurrentWeather?
    
    func getcurrentCityWeather(loc:CLLocation, completion: @escaping (CurrentWeather) -> ())
    {
        DispatchQueue.main.async {
            //api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
            ServiceManager.fetchweatherforLocation(from:"https://api.openweathermap.org/data/2.5/weather?lat=\(loc.coordinate.latitude)&lon=\(loc.coordinate.longitude)&appid=fae7190d7e6433ec3a45285ffcf55c86&units=metric", completion: {cw in
            self.cityweather = cw as? CurrentWeather
                let w = self.cityweather?.weather as? [WeatherElement]
                print(w)
                print(self.cityweather?.weather?.first?.weatherDescription)
                print(self.cityweather?.main?.tempMax)
                DispatchQueue.main.async {
                    completion(cw )
                          }

        })
        }
        
    }
}
