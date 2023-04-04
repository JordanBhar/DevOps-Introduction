//
//  Assignment_3_DistributedMobilityApp.swift
//  Assignment_3_DistributedMobility
//
//  Created by Jordan Bhar on 2023-03-31.
//

import SwiftUI

@main
struct Assignment_3_DistributedMobilityApp: App {
    
    let weatherController = WeatherController()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(weatherController)
        }
    }
}
