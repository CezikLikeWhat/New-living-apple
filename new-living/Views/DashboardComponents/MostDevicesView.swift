//
//  MostDevicesView.swift
//  new-living
//
//  Created by Cezary Maćkowski on 18/08/2022.
//

import SwiftUI

struct MostDevicesView: View {
    
    @State var mostDevice: MostDevice = MostDevice(type: TypeOfDevice.empty, quantity: 0)
    @State var paddingFixDistanceSensor: CGFloat = 0
    
    var body: some View {
        ZStack{
            Color(red: 160/255, green: 236/255, blue: 243/255)
            HStack{
                VStack(alignment: .leading, spacing: 20-paddingFixDistanceSensor){
                    VStack {
                        Text("Most devices are of the type:")
                            .font(.title2)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    VStack {
                        Text("\(mostDevice.type.rawValue)")
                            .font(.title2)
                            .bold()
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    VStack {
                        Text("Quantity:")
                            .font(.title2)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    VStack{
                        Text("\(mostDevice.quantity)")
                            .font(.title2)
                            .bold()
                    }
                }.onAppear{
                    Task{
                        do{
                            mostDevice = try await RestController.mostDevice(email: User.shared.email)
                        } catch {
                            print("Error")
                        }
                        if(mostDevice.type == TypeOfDevice.distanceSensor){
                            paddingFixDistanceSensor = 10
                        }else if(mostDevice.type == TypeOfDevice.empty){
                            paddingFixDistanceSensor = -3
                        }else{
                            paddingFixDistanceSensor = 0
                        }
                    }
                }
                
                Spacer(minLength: 0)
                
            }
            .padding()
            
        }
        .cornerRadius(10)
        .padding(.trailing, 15)
        .padding(.bottom, 60)
        .frame(width: 180, height: 285)
    }
}

struct MostDevicesView_Previews: PreviewProvider {
    static var previews: some View {
        MostDevicesView()
    }
}
