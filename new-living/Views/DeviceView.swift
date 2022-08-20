//
//  DeviceView.swift
//  new-living
//
//  Created by Cezary Maćkowski on 14/07/2022.
//

import SwiftUI

struct DeviceView: View {
    
    @Binding var device: Device
    @Binding var devices: [Device]
    
    //SnackBar
    @State var snackbarIsActive: Bool = false
    @State var snackBarLogo: String = ""
    @State var snackBarColor: Color = Color.green
    @State var apiMessage: String = ""
    
    var body: some View {
        
        VStack{
            Image("\(device.image)")
                .resizable()
                .frame(width: 150, height: 150)
                .padding()
                .overlay {
                    Circle().stroke(Gradients.mainGradient, lineWidth: 4).frame(width: 220, height: 220)
                }
                .shadow(radius: 7)
            
            Spacer()
            List{
                Section(header: Text("Device")){
                    HStack{
                        Text("Name:")
                        Spacer()
                        Text("\(device.name)")
                    }
                    HStack{
                        Text("MAC:")
                        Spacer()
                        Text("\(device.mac)")
                    }
                    HStack{
                        Text("Type:")
                        Spacer()
                        Text("\(device.type.rawValue)")
                    }
                    HStack{
                        Text("Description:")
                        Spacer()
                        Text("\(device.description)")
                    }
                }
                Section(header: Text("Options")){
                    DeviceOptionsView(device: $device)
                }
            }.padding(.top, 30)
            
            
            Spacer()
            
            
        }.onAppear {
            UITableView.appearance().backgroundColor = UIColor.white
         }
        .onDisappear{
            UITableView.appearance().backgroundColor = UIColor.systemGroupedBackground
        }
        
        .navigationBarItems(trailing: Button(action: {
            Task {
                do {
                    let (apiResponse, response) = try await RestController.removeDevice(device: device)

                    if(response?.statusCode == 200){
                        snackBarLogo = "checkmark.seal"
                        snackBarColor = .green

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                            if let index = devices.firstIndex(where: {$0.id == device.id}) {
                              devices.remove(at: index)
                            }
                        }
                        
                    }else{
                        snackBarLogo = "xmark.seal"
                        snackBarColor = .red
                    }
                    snackbarIsActive = true
                    apiMessage = apiResponse.info
                    
                } catch {
                    print("Request failed with error: \(error)")
                }
            }
        }, label: {
            Image(systemName: "minus.square")
            
        }))
        .alertMessage(isPresented: $snackbarIsActive, type: .centered, autoHideIn: 1.2){Alert(message: $apiMessage, image: $snackBarLogo, color: $snackBarColor)}
    }
    
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceView(device: .constant(Device(id: UUID().uuidString, name: "testowa nazwa", mac: "00:00:00:00", type: TypeOfDevice.raspberry, description: "Testowy opis", image: "Raspberry", actions: ["Enable": true])), devices: .constant([]))
    }
}
