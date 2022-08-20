//
//  DeviceActions.swift
//  new-living
//
//  Created by Cezary Maćkowski on 01/08/2022.
//

import Foundation

struct DeviceActions {
    
    static func getActionBy(Type type: TypeOfDevice) -> [String:Bool]{
        switch type{
        case .raspberry:
            return [
                "Enable device": false,
                "Error notification": false,
                "Reset device": false,
                "Enable SSH": false
            ]
        case .esp32:
            return [
                "Enable device": false,
                "Error notification": false,
                "Reset device": false,
                "Enable HTTP Server": false
            ]
        case .lightBulb:
            return [
                "Enable bulb": false,
                "Enable rainbow effect": false
            ]
        case .distanceSensor:
            return [
                "Enable sensor": false,
                "Set at 10cm": false,
                "Set at 50cm": false,
                "Set at 1m": false
            ]
        case .ledStrip:
            return [
                "Enable strip": false,
                "Enable rainbow effect": false,
                "Enable the breathing effect": false,
                "Enable the explosion effect": false
            ]
        case .radio:
            return [
                "Enable radio": false,
                "Reset radio": false,
                "Play news station": false,
                "Play music station": false,
            ]
        case .empty:
            return [:]
        }
    }
}
