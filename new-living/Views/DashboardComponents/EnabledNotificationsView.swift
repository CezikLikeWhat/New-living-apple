//
//  EnabledNotificationsView.swift
//  new-living
//
//  Created by Cezary Maćkowski on 18/08/2022.
//

import SwiftUI

struct EnabledNotificationsView: View {
    
    @State var userNotification: Notification = Notification(email: false, popup: false, sms: false, telegram: false, discord: false)
    
    @State var paddingTop: CGFloat = 50
    @State var paddingBottom: CGFloat = 50
    
    var body: some View {
        ZStack{
            Color(red: 161/255, green: 218/255, blue: 246/255)
            HStack{
                VStack(alignment: .leading, spacing: 20){
                    VStack {
                        Text("Enabled notifications:")
                            .font(.title2)
                            .fixedSize(horizontal: false, vertical: true)
                    }.padding(.top)
                    
                    VStack(alignment: .leading){
                        if(userNotification.email){
                            Text("Email")
                                .font(.title2)
                                .bold()
                        }
                        if(userNotification.popup){
                            Text("PopUp")
                                .font(.title2)
                                .bold()
                        }
                        if(userNotification.sms){
                            Text("SMS")
                                .font(.title2)
                                .bold()
                        }
                        if(userNotification.telegram){
                            Text("Telegram")
                                .font(.title2)
                                .bold()
                        }
                        if(userNotification.discord){
                            Text("Discord")
                                .font(.title2)
                                .bold()
                        }
                        if(!userNotification.email &&
                           !userNotification.popup &&
                           !userNotification.sms &&
                           !userNotification.telegram &&
                           !userNotification.discord){
                            Text("Empty")
                                .font(.title2)
                                .bold()
                        }
                        
                    }
                    .padding(.top, paddingTop)
                    .padding(.bottom, paddingBottom)
                    
                }.onAppear{
                    Task{
                        do{
                            let (apiResponse,response) = try await RestController.getAllNotifications(email: User.shared.email)
                            if(response?.statusCode == 200){
                                userNotification = Notification.fromApi(api: apiResponse)
                                (paddingTop,paddingBottom) = userNotification.getNumberOfNotifications()
                            }
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
        .padding(.leading, 15)
        .padding(.bottom, 60)
        .padding(.trailing, 10)
        .frame(width: 180, height: 285)
    }
}

struct EnabledNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        EnabledNotificationsView()
    }
}
