//
//  TypeOfDevice.swift
//  new-living
//
//  Created by Cezary Maćkowski on 10/07/2022.
//

import Foundation

enum TypeOfDevice: String, Codable, CaseIterable {
    case raspberry = "Raspberry"
    case esp32 = "ESP"
    case lightBulb = "Light Bulb"
    case distanceSensor = "Distance Sensor"
    case ledStrip = "Led Strip"
    case radio = "Radio"
    case empty = ""
}
