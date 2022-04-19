//
//  weatherViewModel.swift
//  Weather App
//
//  Created by SARVADHI on 11/04/22.
//

import Foundation
import UIKit

struct weatherViewModel {
    
    weak var vc :searchWeatherVC?
    weak var DetailVc : DetailWeatherVC?
    var weatherModels : weatherModel?
     func weatherCityApicall(cityName : String, onSuccess: @escaping (Any) -> Void,onError: @escaping () -> Void) {
        let urlString =  Api.baseurl + "&q=\(cityName)"
        let url = URL(string: urlString)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if  error == nil {
                if let data = data {
                    do{
                        let Response = try JSONDecoder().decode(weatherModel.self, from: data)
                        DispatchQueue.main.async {
                            
                            self.vc?.weatherModels = Response
                            self.DetailVc?.weatherModels = Response
                           
                        }
                       
                        
                      
                        onSuccess(Response)
                    
                        print(Response)
                    
                    }catch{
                        onError()
                        print(error.localizedDescription)
                    }
                }
            }
            
        }.resume()
        

                    
    }
}
