//
//  GreetingView.swift
//  new-living
//
//  Created by Cezary Maćkowski on 18/08/2022.
//

import SwiftUI

struct GreetingView: View {
    
    var body: some View {
        ZStack{
            Color(red: 162/255, green: 190/255, blue: 251/255)
            HStack{
                VStack(alignment: .leading){
                    VStack {
                        Text("Hello,")
                            .font(.largeTitle)
                    }.padding(.top)
                    
                    Spacer()
                    
                    VStack {
                        Text(verbatim: "\(User.shared.email.capitalizingFirstLetter())")
                            .font(.title2)
                            .bold()
                            .padding(.top)
                            .fixedSize(horizontal: false, vertical: true)
                        
                    }
                    .padding(.bottom, 50)
                    .padding(.top, 20)
                    
                }
                
                Spacer(minLength: 0)
                
            }
            .padding()
            
        }
        .cornerRadius(10)
        .padding(.leading, 15)
        .padding(.top, 60)
        .padding(.trailing, 10)
        .frame(width: 180, height: 285)
    }
}

struct GreetingView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingView()
    }
}
