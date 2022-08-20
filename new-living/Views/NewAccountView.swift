//
//  NewAccountView.swift
//  new-living
//
//  Created by Cezary Maćkowski on 07/07/2022.
//

import SwiftUI

struct NewAccountView: View {
    
    @Environment(\.dismiss) var dismiss
    
    //Presentation View
    @State var emailAlertIsPresented: Bool = false
    @State var passwordAlertIsPresented: Bool = false
    @State var bothPasswordAlertIsPresented: Bool = false
    
    //User
    @State var name: String = ""
    @State var surname: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordAgain: String = ""
    @State var apiMessage: String = ""
    
    //SnackBar
    @State var snackbarIsActive: Bool = false
    @State var snackBarLogo: String = ""
    @State var snackBarColor: Color = Color.green
    
    @FocusState private var focusOn: FocusableField?
    
    var formIsInvalid:Bool {
        email.isEmpty || password.isEmpty || passwordAgain.isEmpty
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Name")){
                    TextField("", text: $name)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .focused($focusOn, equals: .name)
                }
                
                Section(header: Text("Surname")){
                    TextField("", text: $surname)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .focused($focusOn, equals: .name)
                }
                Section(header: Text("Email")){
                    TextField("", text: $email)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .focused($focusOn, equals: .name)
                }
                
                Section(header: Text("Password")){
                    PasswordView(password: $password)
                        .focused($focusOn, equals: .password)
                }
                Section(header: Text("Repeat password")){
                    PasswordView(password: $passwordAgain)
                        .focused($focusOn, equals: .passwordAgain)
                }
                
                Section{
                    Button(action:{
                        if(!Validator.validateEmail(email: email)){
                            emailAlertIsPresented = true
                            return
                        }
                        if(!Validator.validatePassword(password: password)){
                            passwordAlertIsPresented = true
                            return
                        }
                        if(password != passwordAgain){
                            bothPasswordAlertIsPresented = true
                            return
                        }
                        Task {
                            do {
                                let account = Account(name: name, surname: surname, email: email.lowercased(), password: password)
                                let (apiResponse, response) =  try await RestController.signInNewUser(account: account)

                                if(response?.statusCode == 200){
                                    snackBarLogo = "checkmark.seal"
                                    snackBarColor = .green
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                        dismiss()
                                    }
                                }else{
                                    name = ""
                                    surname = ""
                                    email = ""
                                    password = ""
                                    passwordAgain = ""
                                    snackBarLogo = "xmark.seal"
                                    snackBarColor = .red
                                    focusOn = .name
                                }
                                snackbarIsActive = true
                                apiMessage = apiResponse.info
                                
                            } catch {
                                print("Request failed with error: \(error)")
                            }
                        }
                    }) {
                        Text("Create account")
                    }
                    .disabled(formIsInvalid)
                    .alert(Text("Your email is invalid"), isPresented: $emailAlertIsPresented, actions: {
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Check corectness of your email")
                    })
                    .alert(Text("Password is too weak"), isPresented: $passwordAlertIsPresented, actions: {
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Make stronger your password\n- ")
                    })
                    .alert(Text("Your passwords are not identical"), isPresented: $bothPasswordAlertIsPresented, actions: {
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Check corectness of your passwords")
                    })
                }
            }
            .navigationTitle("Sign in")
        }
        .alertMessage(isPresented: $snackbarIsActive, type: .snackbar, autoHideIn: 1.2){Alert(message: $apiMessage, image: $snackBarLogo, color: $snackBarColor)}
        
       
    }
}

struct NewAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NewAccountView()
    }
}
