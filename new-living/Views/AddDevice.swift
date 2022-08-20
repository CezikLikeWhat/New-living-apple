//
//  AddDevice.swift
//  new-living
//
//  Created by Cezary Maćkowski on 30/07/2022.
//

import SwiftUI

struct AddDevice: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var Devices: [Device]
    
    @State var macAlertIsPresented: Bool = false
    
    //Device
    @State var name: String = ""
    @State var mac: String = ""
    @State var type: TypeOfDevice = .raspberry
    @State var description: String = ""
    @State var apiMessage: String = ""
    
    //SnackBar
    @State var snackbarIsActive: Bool = false
    @State var snackBarLogo: String = ""
    @State var snackBarColor: Color = Color.green
    
    var formIsInvalid:Bool {
        name.isEmpty || mac.isEmpty
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Name")){
                    TextField("", text: $name)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                }
                Section(header: Text("MAC")){
                    TextField("", text: $mac)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                }
                Section(header: Text("Type")){
                    Picker("", selection: $type){
                        ForEach(TypeOfDevice.allCases, id: \.self){ device in
                            if(device.rawValue != ""){
                                Text("\(device.rawValue)")
                            }
                        }
                    }.pickerStyle(.menu)
                }
                Section(header: Text("Description")){
                    TextField("", text: $description)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                }
               
                Section{
                    Button(action:{
                        if(!Validator.validateMAC(mac: mac)){
                            macAlertIsPresented = true
                            return
                        }
                        Task {
                            do {
                                let device = Device(id: UUID().uuidString.lowercased(), name: name, mac: mac, type: type, description: description, image: type.rawValue, actions: [:])
                                let (apiResponse, response) =  try await RestController.addOrUpdateNewDevice(path: "addDevice", email: User.shared.email, device: device)

                                if(response?.statusCode == 200){
                                    snackBarLogo = "checkmark.seal"
                                    snackBarColor = .green
                                    let addedDevice = try await RestController.getDevice(id: device.id)
                                    Devices.append(addedDevice)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                        dismiss()
                                    }
                                }else{
                                    name = ""
                                    mac = ""
                                    type = .raspberry
                                    snackBarLogo = "xmark.seal"
                                    snackBarColor = .red
                                }
                                snackbarIsActive = true
                                apiMessage = apiResponse.info
                                
                            } catch {
                                print("Request failed with error: \(error)")
                            }
                        }
                    }) {
                        Text("Add device")
                    }
                    .disabled(formIsInvalid)
                    .alert(Text("MAC is invalid"), isPresented: $macAlertIsPresented, actions: {
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Check corectness of your MAC")
                    })
                
                }
            }
            .navigationTitle("Add device")
        }
        .alertMessage(isPresented: $snackbarIsActive, type: .snackbar, autoHideIn: 1.2){Alert(message: $apiMessage, image: $snackBarLogo, color: $snackBarColor)}
        
       
    }
}

struct AddDevice_Previews: PreviewProvider {
    static var previews: some View {
        AddDevice(Devices: .constant([]))
    }
}
