//
//  RaspberryOptions.swift
//  new-living
//
//  Created by Cezary Maćkowski on 31/07/2022.
//

import SwiftUI

struct RaspberryOptions: View {
    
    @State var isOn: Bool = false
//    @State var : Bool = false
    
    let cos = LinearGradient(
        gradient: Gradient(colors: [Color.white]),
        startPoint: .top,endPoint: .bottom)
    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color.pink, Color.yellow]),
        startPoint: .top, endPoint: .bottom)
        
    let colorss = Color.yellow.description

    var body: some View {
        HStack{
            VStack{
                
                Button(action: {
                    isOn.toggle()
                }, label: {
                    Text("Enable device")
                        .padding()
                        .background(isOn ? .green : .white, in: RoundedRectangle(cornerRadius: 15))
                        .foregroundColor(.black)
                })
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black, lineWidth: 4)
                }
                .buttonStyle(.borderless)
                .padding()


                Button(action: {
                    isOn.toggle()
                }, label: {
                    Text("Error notification")
                        .padding()
                        .background(isOn ? .green : .white, in: RoundedRectangle(cornerRadius: 15))
                        .foregroundColor(.black)
                })
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black, lineWidth: 4)
                }
                .buttonStyle(.borderless)
                .padding()
            }

            VStack{

                Button(action: {
                    isOn.toggle()
                }, label: {
                    Text("Reset device")
                        .padding()
                        .background(isOn ? .green : .white, in: RoundedRectangle(cornerRadius: 15))
                        .foregroundColor(.black)
                })
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black, lineWidth: 4)
                }
                .buttonStyle(.borderless)
                .padding()


                Button(action: {
                    isOn.toggle()
                }, label: {
                    Text("Enable SSH")
                        .padding()
                        .background(isOn ? .green : .white, in: RoundedRectangle(cornerRadius: 15))
                        .foregroundColor(.black)
                })
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black, lineWidth: 4)
                }
                .buttonStyle(.borderless)
                .padding()

            }
            
            
        }
        
        
    }
}

struct RaspberryOptions_Previews: PreviewProvider {
    static var previews: some View {
        RaspberryOptions()
    }
}
