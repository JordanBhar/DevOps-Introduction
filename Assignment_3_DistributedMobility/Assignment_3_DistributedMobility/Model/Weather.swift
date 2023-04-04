//
//  Weather.swift
//  Assignment_3_DistributedMobility
//
//  Created by Jordan Bhar on 2023-03-31.
//

import Foundation

struct Weather: Codable {
    let current: Current
    let location : Location
    

    struct Current: Codable {
        let last_updated_epoch: Int
        let last_updated: String
        let temp_c : Double
        let temp_f : Double
        let is_day: Int
        let condition: Condition
        let wind_mph: Double
        let wind_kph : Double
        let wind_degree: Int
        let wind_dir: WindDir
        let pressure_mb: Double
        let pressure_in: Double
        let precip_mm : Double
        let precip_in : Double
        let humidity : Int
        let cloud: Int
        let feelslike_c, feelslike_f: Double
        let vis_km : Double
        let vis_miles : Double
        let uv: Int
        let gust_mph: Double
        let gust_kph: Double
    }

    struct Condition: Codable {
        let text, icon: String
        let code: Int
    }

    enum WindDir: String, Codable {
        case null = "NULL"
        case nw = "NW"
        case nnw = "NNW"
        case n = "N"
        case nne = "NNE"
        case ne = "NE"
        case ene = "ENE"
        case e = "E"
        case ese = "ESE"
        case se = "SE"
        case sse = "SSE"
        case s = "S"
        case ssw = "SSW"
        case sw = "SW"
        case wsw = "WSW"
        case w = "W"
        case wnw = "WNW"
    }


    struct Location: Codable {
        let name, region, country: String
        let lat, lon: Double
        let tz_id: String
        let localtime_epoch: Int
        let localtime: String
    }
    
    init(){
        current = Current.init(last_updated_epoch: 0, last_updated: "", temp_c: 0.0, temp_f: 0.0, is_day: 0, condition: Condition(text: "", icon: "", code: 0), wind_mph: 0.0, wind_kph: 0, wind_degree: 0, wind_dir: WindDir.null, pressure_mb: 0, pressure_in: 0.0, precip_mm: 0, precip_in: 0, humidity: 0, cloud: 0, feelslike_c: 0.0, feelslike_f: 0.0, vis_km: 0, vis_miles: 0, uv: 0, gust_mph: 0.0, gust_kph: 0)
        
        location = Location.init(name: "", region: "", country: "", lat: 0.0, lon: 0.0, tz_id: "", localtime_epoch: 0, localtime: "")
    }
    
    

}
