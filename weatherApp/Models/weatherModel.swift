//
//  weatherModel.swift
//  Weather App
//
//  Created by SARVADHI on 11/04/22.
//

import Foundation
import UIKit



// MARK: - Welcome
struct weatherModel: Codable {
    let coord: Coord
    let weather: [weatherID]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
//    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

struct weatherID: Codable {
    let imageId : Int
    enum CodingKeys : String , CodingKey {
       case imageId = "id"
    }
}
//struct WeatherID : Codable  {
//    let waeatheridImg: Int
//    let main, weatherDescription, icon: String
//
//    enum CodingKeys: String, CodingKey {
//        case waeatheridImg = "id"
//        case  main
//        case weatherDescription = "description"
//        case icon
//    }
    

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
//struct Sys: Codable {
//    let type, id: Int
//    let country: String
//    let sunrise, sunset: Int
//}

// MARK: - Weather


// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}

