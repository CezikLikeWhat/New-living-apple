//
//  AboutApplicationView.swift
//  new-living
//
//  Created by Cezary Maćkowski on 16/07/2022.
//

import SwiftUI

struct AboutApplicationView: View {
    
    var body: some View {
        
        VStack{
            
            Image("NewLivingImage")
                .resizable()
                .frame(width: 200, height: 200, alignment: .top)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(Gradients.mainGradient, lineWidth: 4)
                }
                .shadow(radius: 7)
                .scaledToFit()
                .offset(y: -20)
                
            Text("The New Living app was created for the \n\"Apple Device Programming\" class and is part of the New Living system. It's an open source system that allows users to easily and modularly create their own smart-house, where users can create their own modules and share them with other users. \nThe entire system is being developed for an engineering thesis at the Faculty of Mathematics and Computer Science at the Nicolaus Copernicus University in Torun.")
                .padding()
                .font(.body)
                .lineSpacing(10)
                .multilineTextAlignment(.center)
                
        }
        
        
        
            .navigationTitle("About application")
    }
}

struct AboutApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        AboutApplicationView()
            
    }
}
