//
//  new_livingApp.swift
//  new-living
//
//  Created by Cezary Maćkowski on 19/06/2022.
//

import SwiftUI

@main
struct new_livingApp: App {
    
    @State var logged: Bool = false
    
    let gradient = LinearGradient(
        gradient: Gradient(colors: [.green,.blue]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    var body: some Scene {
        
        WindowGroup {
            if(!logged){
                LogInView(logged: $logged)
            }else{
                TabView{
                    
                    NavigationView{
                        Dashboard()
                    }.tabItem{
                        Image(systemName: "house.fill")
                        Text("Dashboard")
                    }
                    
                    NavigationView{
                        DevicesView(Devices: [])
                    }.tabItem{
                        Image(systemName: "d.circle.fill")
                        Text("Devices")
                    }
                    
                    NavigationView{
                        SettingsView()
                    }.tabItem{
                        Image(systemName: "gear.circle.fill")
                        Text("Settings")
                    }
                    
                    NavigationView{
                        ContactView()
                    }.tabItem{
                        Image(systemName: "person.fill")
                        Text("Contact")
                    }
                    
                    NavigationView{
                        AboutApplicationView()
                    }.tabItem{
                        Image(systemName: "info.circle.fill")
                        Text("New Living")
                    }
                }
                .accentColor(.indigo)
                .preferredColorScheme(.light)
                .tint(.indigo)

            }
        }
    }
}
