//
//  DisplayWeather.swift
//  Assignment_3_DistributedMobility
//
//  Created by Jordan Bhar on 2023-03-31.
//

import SwiftUI
import MapKit

struct DisplayWeather: View {
    @EnvironmentObject var weatherController : WeatherController
    
    private var widgetBoxSizeHeight : CGFloat = 100.0
    private var widgetBoxSizeWidth : CGFloat = 175.0
    private var widgetBoxLineWidth : CGFloat = 2
    
    
    var body: some View {
        
        
        VStack{
            Group{
                Text("\(weatherController.weatherData.location.name) , \(weatherController.weatherData.location.region)")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Divider()
                    .foregroundColor(.white)
                
                
            }
            
            MyMap(lattitude: weatherController.weatherData.location.lat, longitude: weatherController.weatherData.location.lon)
                .cornerRadius(16)
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 600 )
                .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white, lineWidth: widgetBoxLineWidth)
                    )
            
//                ScrollView(.horizontal) {
//
//                HStack(spacing: 10) {
//
//                    AsyncImage(url: URL(string: "https://maps.aerisapi.com/q91rYnLpfbUVof3Yf7CJS_NPP7LBr7KLB6Jr68LLSFozAbwSrsuMY1tPEnRBAZ/radar/300x300/\(weatherController.weatherData.location.lat),\(weatherController.weatherData.location.lon),7/current.png"))
//                        .scaledToFit()
//                        .frame(width: 125, height: 125)
//
//
//
//                }
//            }
            
        
            
                

            
            Spacer()
                .frame(height: 30)
            
            Text("\(weatherController.weatherData.current.condition.text) weather")
                .padding(.top)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 24))
            
            VStack{
                HStack(spacing: 50){
                    
                    VStack{
                        Text("\(weatherController.weatherData.current.temp_c , specifier: "%.2f")°c")
                            .bold()
                        Divider()
                            .frame(width: 55)
                        Text("\(weatherController.weatherData.current.feelslike_c, specifier: "%.2f")°c")
                        
                    }
                    .frame(width: 125, height: 125)
                    .background(LinearGradient(colors: [.blue, .purple],startPoint: .topLeading,endPoint: .bottomTrailing).cornerRadius(16))
                    .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.white, lineWidth: widgetBoxLineWidth)
                        )
                    .padding(10)
                    
                    
                    AsyncImage(url: URL(string: "https:\(weatherController.weatherData.current.condition.icon)"))
                        .scaledToFit()
                        .frame(width: 125, height: 125)
                        .background(LinearGradient(colors: [.blue, .purple],startPoint: .topLeading,endPoint: .bottomTrailing).cornerRadius(16))
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.white, lineWidth: widgetBoxLineWidth)
                            )
                    
                }
                .padding(.bottom)
                
                
                ScrollView(.horizontal) {
                    
                    HStack(spacing: 10) {
                        
                        VStack(){
                            if(weatherController.weatherData != nil){
                                Text("Precipitation")
                                    .bold()
                                    .font(.system(size: 15))
                                Text("\(weatherController.weatherData.current.precip_mm, specifier: "%.2f") mm")
                            }else{
                                Text("Loading")
                            }
                        }
                        .frame(width: widgetBoxSizeWidth, height: widgetBoxSizeHeight)
                        .background(LinearGradient(colors: [.blue, .purple],startPoint: .topLeading,endPoint: .bottomTrailing).cornerRadius(16))
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.white, lineWidth: widgetBoxLineWidth)
                            )
                                            
                        
                        VStack(){
                            if(weatherController.weatherData  != nil){
                                Text("Visibility")
                                    .bold()
                                    .font(.system(size: 15))
                                Text("\(weatherController.weatherData.current.vis_km , specifier: "%.2f") km")
                            }else{
                                Text("Loading")
                            }
                        }
                        .frame(width: widgetBoxSizeWidth, height: widgetBoxSizeHeight)
                        .background(LinearGradient(colors: [.blue, .purple],startPoint: .topLeading,endPoint: .bottomTrailing).cornerRadius(16))
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.white, lineWidth: widgetBoxLineWidth)
                            )
                        

                        
                        VStack{
                            if(weatherController.weatherData != nil){
                                Text("Wind")
                                    .font(.system(size: 15))
                                    .bold()
                                Text("\(weatherController.weatherData.current.wind_kph, specifier: "%.2f") km/h")
                                Text("Dir: \(weatherController.weatherData.current.wind_dir.rawValue)")
                            }else{
                                Text("Loading")
                            }
                        }
                        .frame(width: widgetBoxSizeWidth, height: widgetBoxSizeHeight)
                        .background(LinearGradient(colors: [.blue, .purple],startPoint: .topLeading,endPoint: .bottomTrailing).cornerRadius(16))
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.white, lineWidth: widgetBoxLineWidth)
                            )
                
                        
                        VStack{
                            if(weatherController.weatherData  != nil){
                                Text("UV Index")
                                    .font(.system(size: 15))
                                    .bold()
                                Text("\(weatherController.weatherData.current.uv)")
                            }else{
                                Text("Loading")
                            
                            }
                                
                        }
                        .frame(width: widgetBoxSizeWidth, height: widgetBoxSizeHeight)
                        .background(LinearGradient(colors: [.blue, .purple],startPoint: .topLeading,endPoint: .bottomTrailing).cornerRadius(16))
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.white, lineWidth: widgetBoxLineWidth)
                                
                            )
                    }
                    .padding(.horizontal)
                    
                }
            }
            
            
            Spacer()
        }
        .background(Color.purple)
    }
}




struct MyMap : UIViewRepresentable{

    typealias UIViewType = MKMapView
    private var lattitude : Double
    private var longitude : Double
    
    @State private var result : String = ""
    
    
    init(lattitude: Double , longitude: Double){
        self.longitude = longitude
        self.lattitude = lattitude
    }

    func makeUIView(context: Context) -> MKMapView {
        let sourceCoordinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion

        sourceCoordinates = CLLocationCoordinate2D(latitude: self.lattitude, longitude: self.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        region = MKCoordinateRegion(center: sourceCoordinates, span: span)

        let map = MKMapView()

        map.mapType = MKMapType.standard
        map.setRegion(region, animated: true)
        map.showsUserLocation = false
        map.isZoomEnabled = false
        map.isScrollEnabled = true

        return map

    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        print(#function, "Trying to Update Map")

        let sourceCoordinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion

        sourceCoordinates = CLLocationCoordinate2D(latitude: self.lattitude, longitude: self.longitude)

        
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        region = MKCoordinateRegion(center: sourceCoordinates, span: span)

        uiView.setRegion(region, animated: true)

    }
    
    

}

struct DisplayWeather_Previews: PreviewProvider {
    static var previews: some View {
        DisplayWeather()
    }
}
