//
//  Row.swift
//  new-living
//
//  Created by Cezary Maćkowski on 10/07/2022.
//

import SwiftUI

struct Row: View {
    
    var device: Device
    
    var body: some View {
        HStack{
            
            VStack(alignment:.leading){
                Text(device.name)
                    .font(.headline)
                Text("MAC: \(device.mac)")
                    .font(.footnote)
                Text("Type: \(device.type.rawValue)")
                    .font(.footnote)

            }.padding(.vertical, 5)
            
            Spacer()
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(device: Device(id: UUID().uuidString, name: "BathRoom", mac: "00:00:00:00:00", type: TypeOfDevice.raspberry, description: "Łazienka", image: "gear", actions: ["Enabled": true]))
    }
}
