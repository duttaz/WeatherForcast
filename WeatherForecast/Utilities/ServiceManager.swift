//
//  ServiceManager.swift
//  WeatherForecast
//
//  Created by dattaphani on 06/08/21.
//
struct Places {
    let str:String
}
import Foundation
//
//  ServiceManager.swift
//  Location
//
//  Created by dattaphani on 20/04/21.
//

import UIKit

enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}


class ServiceManager: NSObject {
    //https://maps.googleapis.com/maps/api/geocode/json?latlng=44.4647452,7.3553838&key=YOUR_API_KEY
  
    
    //  Preventing initialisation from any other source.
    private override init() {
    }
    
    //  Function to execute GET request and pass data from escaping closure
    class   func executeGetRequest(with urlString: String, completion: @escaping (Data?) -> ()) {
        
        guard let urlPath  = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let requestUrl = URL.init(string: urlPath) else{
            return
        }
        var urlRequest = URLRequest.init(url: requestUrl)
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            //  Log errors (if any)
            if  error != nil {
            //    Helper.showAlert(message: "\(error.debugDescription)", head: "Error", type: 1)
            } else {
                //  Passing the data from closure to the calling method
                DispatchQueue.main.async {
                                completion(data)
                            }
            }
        }.resume()  // Starting the dataTask
    }
    
    //  Function to perform a task - Calls executeGetRequest(with urlString:) and receives data from the closure.
    class  func fetchweatherforLocation(from urlString: String, completion: @escaping (CurrentWeather) -> ()) {
        //  Calling executeGetRequest(with:)
        executeGetRequest(with: urlString) { (data) in  // Data received from closure
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                guard let responseDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary else {
                    throw JSONError.ConversionFailed
                }
                //  JSON parsing
                   let currentWeather = try? JSONDecoder().decode(CurrentWeather.self, from: data)

//                guard let responseDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary else {
//                    throw JSONError.ConversionFailed
//                }
                do {
                    let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
                    DispatchQueue.main.async {
                        completion(currentWeather )
                              }
                       } catch let err {
                           print(err.localizedDescription)
                       }

            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }
    }
    
 }

