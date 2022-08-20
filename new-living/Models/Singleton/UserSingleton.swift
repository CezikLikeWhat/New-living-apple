//
//  UserSingleton.swift
//  new-living
//
//  Created by Cezary Maćkowski on 24/07/2022.
//

import Foundation

class User {
    var email: String = ""
    var password: String = ""
    
    static let shared = User()

    private init() {}
}
