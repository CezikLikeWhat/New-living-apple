//
//  MainView.swift
//  new-living
//
//  Created by Cezary Maćkowski on 23/06/2022.
//

import SwiftUI

struct Dashboard: View {
    
    @State var mostDevice: MostDevice = MostDevice(type: TypeOfDevice.raspberry, quantity: -1)
    
    var body: some View {
        VStack{
            HStack{
                GreetingView()
                
                NumberOfDevicesView()
            }
            
            Spacer()
            
            HStack{
                EnabledNotificationsView()
                
                MostDevicesView()
            }
            
        }
        .navigationTitle("Dashboard")
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}


