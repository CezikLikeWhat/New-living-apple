//
//  PasswordView.swift
//  new-living
//
//  Created by Cezary Maćkowski on 07/08/2022.
//

import SwiftUI

struct PasswordView: View {
    
    @Binding var password: String
    @State var showPassword: Bool = false
    
    var body: some View {
        HStack{
            
            if(showPassword){
                TextField("", text: $password, prompt: Text("Required"))
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
            }else{
                SecureField("", text: $password, prompt: Text("Required"))
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
            }
            
            Button(action: {
                showPassword.toggle()
            }, label: {
                Image(systemName: showPassword ? "eye" : "eye.slash")
                    .tint(.black)
            }).buttonStyle(.borderless)
        }
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView(password: .constant("zaq1@WSX"))
    }
}
