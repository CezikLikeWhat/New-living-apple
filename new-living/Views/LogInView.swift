//
//  LogInView.swift
//  new-living
//
//  Created by Cezary Maćkowski on 26/06/2022.
//

import SwiftUI

struct LogInView: View {
    
    @Binding var logged: Bool
    
    //Presentation View
    @State var showingNewAccountView: Bool = false
    @State var alertIsPresented = false
    
    //User
    @State var email: String = ""
    @State var password: String = ""
    @State var apiMessage: String = ""
    
    //SnackBar
    @State var snackbarIsActive: Bool = false
    @State var snackBarLogo: String = ""
    @State var snackBarColor: Color = Color.green
    
    @FocusState private var focusOn: FocusableField?
    
    var formIsInvalid:Bool {
        email.isEmpty || password.isEmpty
    }
    
    var body: some View {
        
        NavigationView{
            Form{
                Section(header: Text("Email")){
                    TextField("", text: $email)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .focused($focusOn, equals: .email)
                }
                
                Section(header: Text("Password")){
                    PasswordView(password: $password)
                        .focused($focusOn, equals: .password)
                }
                
                Section{
                    Button(action:{
                        Task {
                            if(!ReachabilityController.isConnectedToNetwork()){
                                alertIsPresented = true
                                return
                            }
                            do {
                                let (apiResponse, response) = try await RestController.getInfoThatUserExist(email: email.lowercased(), password: password)

                                if(response?.statusCode == 200){
                                    snackBarLogo = "checkmark.seal"
                                    snackBarColor = .green
                                    User.shared.email = email.lowercased()
                                    User.shared.password = password
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                        logged = true
                                    }
                                    
                                }else{
                                    email = ""
                                    password = ""
                                    snackBarLogo = "xmark.seal"
                                    snackBarColor = .red
                                    focusOn = .email
                                }
                                snackbarIsActive = true
                                apiMessage = apiResponse.info
                                
                            } catch {
                                print("Request failed with error: \(error)")
                            }
                            
                        }
                    }) {
                        Text("Log in")
                    }
                    .disabled(formIsInvalid)
                    .alert(Text("Network is not working"), isPresented: $alertIsPresented, actions: {
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Turn on your network")
                    })
                }
                
                Section{
                    Button("Create account"){
                        showingNewAccountView.toggle()
                    }
                }
            }
            .navigationTitle("Log in")
            
        }
        .alertMessage(isPresented: $snackbarIsActive, type: .snackbar, autoHideIn: 1.2){Alert(message: $apiMessage, image: $snackBarLogo, color: $snackBarColor)}
        .sheet(isPresented: $showingNewAccountView){
            NewAccountView()
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(logged: .constant(false))
    }
}
