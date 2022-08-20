//
//  Device.swift
//  new-living
//
//  Created by Cezary Maćkowski on 10/07/2022.
//

import Foundation

struct Device: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let mac: String
    var type: TypeOfDevice
    let description: String
    let image: String
    var actions: [String:Bool]
}
