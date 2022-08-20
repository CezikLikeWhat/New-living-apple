//
//  DeviceOptionsView.swift
//  new-living
//
//  Created by Cezary Maćkowski on 31/07/2022.
//

import SwiftUI

struct DeviceOptionsView: View {
    
    @Binding var device: Device
    @State var deviceV2: Device
    
    init(device: Binding<Device>){
        self._device = device
        self._deviceV2 = State(initialValue: device.wrappedValue)
    }
    
    var body: some View {
        
        let keys: [String] = device.actions.map{$0.key}.sorted()
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
        
        LazyVGrid(columns: columns, spacing: 20){
            ForEach(keys.indices, id: \.self) {index in

                Button(action: {
                    
                    deviceV2.actions[keys[index]]!.toggle()
                    Task{
                        do{
                            let (_, _) =  try await RestController.addOrUpdateNewDevice(path: "updateDevice", email: User.shared.email, device: deviceV2)
                        } catch {
                            print("Error")
                        }
                    }
                    
                }, label: {
                    Text("\(keys[index])")
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 15))
                        .foregroundColor(.black)
                })
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(deviceV2.actions[keys[index]]! ? Gradients.mainGradient : Gradients.blackGradient, lineWidth: 4)
                }
                .buttonStyle(.borderless)
                .padding()

            }
        }
            
    }
}

struct DeviceOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceOptionsView(device: .constant(Device(id: "ID", name: "NAME", mac: "MAC", type: TypeOfDevice.raspberry, description: "DESCRIPTION", image: TypeOfDevice.raspberry.rawValue, actions: [
            "Enable device": false,
            "Error notification": false,
            "Reset device": false,
            "Enable SSH": false,
            "Enable light": false,
            "Enable Strip": false,
        ])))
    }
}
