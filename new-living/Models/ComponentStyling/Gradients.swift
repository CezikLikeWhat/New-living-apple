//
//  Gradients.swift
//  new-living
//
//  Created by Cezary Maćkowski on 05/08/2022.
//

import Foundation
import SwiftUI

struct Gradients {
    
    static let mainGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 247/255, green: 37/255, blue: 133/255),
            Color(red: 114/255, green: 9/255, blue: 183/255),
            Color(red: 72/255, green: 12/255, blue: 168/255),
            Color(red: 58/255, green: 12/255, blue: 163/255),
            Color(red: 67/255, green: 97/255, blue: 238/255),
            Color(red: 76/255, green: 201/255, blue: 240/255),
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let blackGradient = LinearGradient(
        gradient: Gradient(colors: [
            .black
        ]),
        startPoint: .top,
        endPoint: .top
    )
    
    static let whiteGradient = LinearGradient(
        gradient: Gradient(colors: [
            .white
        ]),
        startPoint: .top,
        endPoint: .top
    )
}
