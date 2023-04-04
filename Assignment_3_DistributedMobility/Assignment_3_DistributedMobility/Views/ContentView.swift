//
//  ContentView.swift
//  Assignment_3_DistributedMobility
//
//  Created by Jordan Bhar on 2023-03-31.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var weatherController : WeatherController
    @State private var selection : Int? = nil
    @State private var weatherSearchBox : String = ""
    
    var body: some View {
        NavigationView{
            
            
            VStack(){
                NavigationLink(destination: DisplayWeather(), tag:1 , selection: self.$selection){}

                Group{
                    Text("Weather Data Search")
                        .font(.title)
                        .bold()
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    Divider()
                    
                }
                
                Spacer()
                                
                Group{
                    
                    TextField("Search Weather", text: $weatherSearchBox)
                        .font(.system(size: 16))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.blue, lineWidth: 4)
                            )
                    
                    Spacer()
                        .frame(height: 40)
                    
                    Button(action:{
                        weatherController.fetchData(location: weatherSearchBox)
                        
                        if(weatherController.weatherData != nil){
                            self.selection = 1
                        }else{
                            //Display error to user
                            Alert(title: Text("Sorry we could not find the Location"))
                        }
                        
                        weatherSearchBox = ""
                    }){
                        Text("Retrive Data")
                            .font(.system(size: 24))
                            .padding(.horizontal, 30)
                            .padding(.vertical, 15)
                            .foregroundColor(Color.white)
                        //Button Styleing
                    }
                    .background(Color.blue)
                    .cornerRadius(10)
                        
                    Spacer()
                    
                }
                
                                
            }
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

