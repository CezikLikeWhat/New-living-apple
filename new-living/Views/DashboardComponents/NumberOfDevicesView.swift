//
//  NumberOfTheDevicesView.swift
//  new-living
//
//  Created by Cezary Maćkowski on 18/08/2022.
//

import SwiftUI

struct NumberOfDevicesView: View {
    
    @State var numberOfUserDevices: Int = -1
    
    var body: some View {
        ZStack{
            Color(red: 161/255, green: 199/255, blue: 249/255)
            HStack{
                VStack(alignment: .leading){
                    VStack {
                        Text("Number of your devices:")
                            .font(.title2)
                            .fixedSize(horizontal: false, vertical: true)
                    }.padding(.top)
                    
                    Spacer()
                    
                    VStack {
                        Text("\(numberOfUserDevices)")
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 50)
                            .padding(.top, 50)
                    }
                    
                }.onAppear{
                    Task{
                        do{
                            numberOfUserDevices = try await RestController.countUserDevices(email: User.shared.email).number
                        } catch {
                            print("Error")
                        }
                    }
                }
                
                Spacer(minLength: 0)
                
            }
            .padding()
            
        }
        .cornerRadius(10)
        .padding(.trailing, 15)
        .padding(.top, 60)
        .frame(width: 180, height: 285)
    }
}

struct NumberOfDevicesView_Previews: PreviewProvider {
    static var previews: some View {
        NumberOfDevicesView()
    }
}
