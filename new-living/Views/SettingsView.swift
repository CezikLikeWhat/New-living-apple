//
//  SettingsView.swift
//  new-living
//
//  Created by Cezary Maćkowski on 04/07/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @State var darkmode = false
    
    @State var notification: Notification = Notification(
        email: false,
        popup: false,
        sms: false,
        telegram: false,
        discord: false
    )

    var body: some View {
        
        Form{
            Section(header: Text("Notifications")){
                Toggle("Email", isOn: $notification.email)
                Toggle("Pop Up", isOn: $notification.popup)
                Toggle("SMS", isOn: $notification.sms)
                Toggle("Telegram", isOn: $notification.telegram)
                Toggle("Discord", isOn: $notification.discord)
            }.onChange(of: notification){ newValue in
                Task{
                    do{
                        let (_, _) =  try await RestController.updateSettings(notification: notification, email: User.shared.email)
                    } catch {
                        print("Error")
                    }
                }
            }
            Section(header: Text("Color Scheme")){
                Toggle("Dark Mode", isOn: $darkmode)
            }
            .alert(Text("Coming soon..."), isPresented: $darkmode, actions: {
                Button("Cancel", role: .cancel, action: { darkmode = false })
            })
        }
        .task{
            do {
                let (apiResponse,response) = try await RestController.getAllNotifications(email: User.shared.email)
                if (response?.statusCode == 200){
                    notification = Notification.fromApi(api: apiResponse)
                }
            } catch {
                print("Error")
            }
        }
        
        .navigationTitle("Settings")
        
    }
}

struct Previews_SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            
    }
}
