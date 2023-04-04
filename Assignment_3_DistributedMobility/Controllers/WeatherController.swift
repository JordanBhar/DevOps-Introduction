//
//  WeatherController.swift
//  Assignment_3_DistributedMobility
//
//  Created by Jordan Bhar on 2023-03-31.
//

import Foundation
import UIKit

class WeatherController : ObservableObject{
    
    @Published var weatherData = Weather()
    
    func fetchData(location : String){
        //Function that takes the users location they want to get the weather of and return data
        
        let headers = [
            "X-RapidAPI-Key": "38f6a0f947mshfdb5e87b243e4d9p13bea8jsn642635524b26",
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
        ]
        
        
//        guard let api = URL(string: "https://api.weatherapi.com/v1/current.json?key=1685107eb2a34bba97f00019222011&q=\(self.latitude),\(self.longitude)") else{
//            print(#function,"Unable to obtiain URL from string")
//            return
//        }

        let request = NSMutableURLRequest(url: NSURL(string: "https://weatherapi-com.p.rapidapi.com/forecast.json?q=\(location)&days=3")! as URL,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                if let httpResponse = response as? HTTPURLResponse{
                    //print(httpResponse)
                    if httpResponse.statusCode == 200{
                        //Response OK
                        
                        DispatchQueue.global().async {
                            do{
                                if(data != nil){
                                    if let jsonData = data{
                                        //performing decoding
                                        let decoder = JSONDecoder()
                                        
                                        //decoder tries to find single object
                                        //note for assignment 3 we need data from a single object, we wont need an array of Json objects
                                        let decodedWeatherInfo = try decoder.decode(Weather.self, from: jsonData)
                                        print(#function, decodedWeatherInfo)
                                        
                                        DispatchQueue.main.async {
                                            self.weatherData = decodedWeatherInfo
                                        }
                                        
                                    }else{
                                        print(#function,"Unable to obtiain Json Data")
                                    }
                                }else{
                                    print(#function,"No Data with response code 200")
                                }
                            }catch let error{
                                print(#function,"No Data Recived \(error)")
                            }
                        }
                        
                    }else{
                        print(#function,"HTTP response status code : \(httpResponse.statusCode)")
                    }
                }
            }
        })

        dataTask.resume()
        
    }
    
}
