//
//  Notification.swift
//  new-living
//
//  Created by Cezary Maćkowski on 24/07/2022.
//

import Foundation
import SwiftUI

struct Notification: Hashable, Codable {
    var email: Bool
    var popup: Bool
    var sms: Bool
    var telegram: Bool
    var discord: Bool
    
    static func fromApi(api: ApiNotifications) -> Notification{
        return Notification(
            email: api.notifications.email,
            popup: api.notifications.popup,
            sms: api.notifications.sms,
            telegram: api.notifications.telegram,
            discord: api.notifications.discord
        )
    }
    
    func getNumberOfNotifications() -> (CGFloat,CGFloat){
        var count: Int = 0
        
        if(email)    { count += 1 }
        if(popup)    { count += 1 }
        if(sms)      { count += 1 }
        if(telegram) { count += 1 }
        if(discord)  { count += 1 }
        
        //Returns two numbers representing padding depending on the number of selected(true) notifications
        if(count == 0 || count == 1) { return (50,50) }
        if(count == 2) { return (40,40) }
        if(count == 3) { return (25,25) }
        if(count == 4) { return (12,12) }
        return (0,0)
    }
}
