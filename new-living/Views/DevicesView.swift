//
//  DevicesView.swift
//  new-living
//
//  Created by Cezary Maćkowski on 04/07/2022.
//

import SwiftUI

struct DevicesView: View {
    
    @State var Devices: [Device]
    @State var showingAddDeviceView: Bool = false
    
    var body: some View {
        
            List{
                ForEach(Devices, id: \.self) { device in
                    NavigationLink(destination: DeviceView(device: $Devices.first(where: {
                        $0.id == device.id
                    })!,devices: $Devices)){
                        
                        Row(device: device)
                        
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarItems(trailing: Button(action: {
                showingAddDeviceView.toggle()
            }, label: {
                Image(systemName: "plus.app")
                
            }))
        
        .onAppear{
            Task{
                do {
                    Devices = try await RestController.getListOfDevices(email: User.shared.email)
                } catch {
                    print("Error")
                }
            }
        }
        
        .navigationTitle("Devices")
        .sheet(isPresented:$showingAddDeviceView){
            AddDevice(Devices: $Devices)
        }
        
    }
}

struct DevicesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DevicesView(Devices: [
                Device(id: UUID().uuidString, name: "Nazwa", mac: "00:00:00:00:00", type: TypeOfDevice.raspberry, description: "Coś", image: "gear", actions: ["Enabled": true]),
                Device(id: UUID().uuidString, name: "Nazwa", mac: "00:00:00:00:00", type: TypeOfDevice.raspberry, description: "Coś", image: "gear", actions: ["Enabled": true]),
                Device(id: UUID().uuidString, name: "Nazwa", mac: "00:00:00:00:00", type: TypeOfDevice.raspberry, description: "Coś", image: "gear", actions: ["Enabled": true]),
                Device(id: UUID().uuidString, name: "Nazwa", mac: "00:00:00:00:00", type: TypeOfDevice.raspberry, description: "Coś", image: "gear", actions: ["Enabled": true])
            ])
        }
    }
}
