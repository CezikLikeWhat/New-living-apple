//
//  Validator.swift
//  new-living
//
//  Created by Cezary Maćkowski on 05/08/2022.
//

import Foundation

struct Validator {
    
    private static let emailRegex: String =  "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    private static let macRegex: String = "^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$"
    private static let passwordRegex: String = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{8,}"
    
    static func validateEmail(email: String) -> Bool {
        do{
            let regex = try NSRegularExpression(pattern: emailRegex)
            let emailAsNsString = email as NSString
            let result = regex.matches(in: email, range: NSRange(location: 0, length: emailAsNsString.length))
            
            if(result.count != 0){
                return true
            }
            
            return false
        
        }catch{
            print("Regex failed - email")
            return false
        }
    }
    
    static func validateMAC(mac: String) -> Bool {
        do{
            let regex = try NSRegularExpression(pattern: macRegex)
            let macAsNsString = mac as NSString
            let result = regex.matches(in: mac, range: NSRange(location: 0, length: macAsNsString.length))
            
            if(result.count != 0){
                return true
            }
            
            return false
        
        }catch{
            print("Regex failed - mac")
            return false
        }
    }
    
    static func validatePassword(password: String) -> Bool {
        do{
            let regex = try NSRegularExpression(pattern: passwordRegex)
            let passwordAsNsString = password as NSString
            let result = regex.matches(in: password, range: NSRange(location: 0, length: passwordAsNsString.length))
            
            if(result.count != 0){
                return true
            }
            
            return false
        
        }catch{
            print("Regex failed - password")
            return false
        }
    }
}
