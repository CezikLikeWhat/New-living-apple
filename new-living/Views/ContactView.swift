//
//  ContactView.swift
//  new-living
//
//  Created by Cezary Maćkowski on 03/07/2022.
//

import SwiftUI

struct ContactView: View {

    var body: some View {
        VStack{
                
            Image("Autor")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200, alignment: .top)
                .scaledToFit()

                .clipShape(Circle())
                .overlay{
                    Circle().stroke(Gradients.mainGradient,lineWidth: 4)
                }
                .offset(y: -20)
            
            Text("Hello, my name is Cezary Maćkowski.\nI'm a student at the Nicolaus Copernicus University in Toruń.\nI'm currently a PHP/Angular Developer at Iteo. My hobbies are cyber security, ethical hacking and cloud.")
                .padding(.horizontal)
                .padding(.top, 10)
                .font(.body)
                .lineSpacing(5)
                .multilineTextAlignment(.center)
                
                
            HStack{
                
                Image("GitHub")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .top)
                    .onTapGesture {
                        UIApplication.shared.open(URL(string: "https://github.com/CezikLikeWhat")!)
                    }.padding()
                
                Image("LinkedIn")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .top)
                    .onTapGesture {
                        UIApplication.shared.open(URL(string: "https://www.linkedin.com/in/cezary-ma%C4%87kowski-662194223/")!)
                    }.padding()
            }
            HStack{
                Image("DockerHub")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .top)
                    .onTapGesture {
                        UIApplication.shared.open(URL(string: "https://hub.docker.com/u/cezarymackowski")!)
                    }.padding()
                
                Image("Gmail")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .top)
                    .onTapGesture {
                        UIApplication.shared.open(URL(string: "mailto:cezarymackowski99@gmail.com")!)
                    }.padding()
            }
            
            .navigationTitle("About me")
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
