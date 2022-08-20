//
//  RestController.swift
//  new-living
//
//  Created by Cezary Maćkowski on 22/06/2022.
//

import Foundation
import SwiftUI

class RestController: ObservableObject {

    private static let urlStr: String = "http://127.0.0.1:5000/"
    
    //GET
    static func getInfoThatUserExist(email: String, password: String) async throws -> (ApiResponse,HTTPURLResponse?) {
        
        let tempUrl = urlStr + "login" + "?email=\(email)&password=\(password)"
        
        let apiURL = URL(string: tempUrl)!
        
        let (data, metadata) = try await URLSession.shared.data(from: apiURL)
        
        let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
        return (apiResponse, metadata as? HTTPURLResponse)
    }
    
    //GET
    static func getListOfDevices(email: String) async throws -> [Device] {
        
        let tempUrl = urlStr + "devices" + "?email=\(email)"
        
        let apiURL = URL(string: tempUrl)!
        
        let (data, _) = try await URLSession.shared.data(from: apiURL)
        
        let listOfDevices = try JSONDecoder().decode(ListOfDevices.self, from: data)
        
        return listOfDevices.devices
    }
    
    //GET
    static func getDevice(id: String) async throws -> Device {
        
        let tempUrl = urlStr + "device" + "?id=\(id)"
        
        let apiURL = URL(string: tempUrl)!
        
        let (data, _) = try await URLSession.shared.data(from: apiURL)
        
        let returnedDevice = try JSONDecoder().decode(Device.self, from: data)
        
        return returnedDevice
    }
    
    //GET
    static func getAllNotifications(email: String) async throws -> (ApiNotifications,HTTPURLResponse?) {
        
        let tempUrl = urlStr + "notifications" + "?email=\(email)"
        
        let apiUrl = URL(string: tempUrl)!
        
        let(data, metadata) = try await URLSession.shared.data(from: apiUrl)
        
        let apiResponse = try JSONDecoder().decode(ApiNotifications.self, from: data)
        
        return (apiResponse, metadata as? HTTPURLResponse)
    }
    
    //GET
    static func countUserDevices(email: String) async throws -> NumberOfDevices {
        
        let tempUrl = urlStr + "countDevices" + "?email=\(email)"
        
        let apiUrl = URL(string: tempUrl)!
        
        let (data, _) = try await URLSession.shared.data(from: apiUrl)
        
        return try JSONDecoder().decode(NumberOfDevices.self, from: data)
    }
    
    //GET
    static func mostDevice(email: String) async throws -> MostDevice {
        
        let tempUrl = urlStr + "mostDevice" + "?email=\(email)"
        
        let apiUrl = URL(string: tempUrl)!
        
        let (data, _) = try await URLSession.shared.data(from: apiUrl)
        
        return try JSONDecoder().decode(MostDevice.self, from: data)
    }
    
    //POST
    static func updateSettings(notification: Notification, email: String) async throws -> (ApiResponse, HTTPURLResponse?) {
        
        let tempUrl = urlStr + "newSettings"
        
        let ApiURL = URL(string: tempUrl)!
        
        let notificationsToUpdate = NewNotifications(email: email, notification: notification)
        
        guard let encodedNotification = try? JSONEncoder().encode(notificationsToUpdate) else {
            throw "Can't create request!"
        }
        
        var request = URLRequest(url: ApiURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedNotification
        
        do {
            let (data, metadata) = try await URLSession.shared.upload(for: request, from: encodedNotification)
            
            let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
    
            return (decodedResponse,metadata as? HTTPURLResponse)
            
        } catch {
            print("Checkout failed.")
        }
        return(ApiResponse(info: "failed"),HTTPURLResponse())
        
    }
    
    //POST
    static func updateDevice(email: String, path: String, device: Device) async throws -> (ApiResponse, HTTPURLResponse?) {
        
        let tempUrl = urlStr + path
        
        let ApiURL = URL(string: tempUrl)!
        
        let tempDevice = DeviceWithEmail(email: email, device: device)
        
        guard let encodedDevice = try? JSONEncoder().encode(tempDevice) else {
            throw "Can't create request!"
        }
        
        var request = URLRequest(url: ApiURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedDevice
        
        do {
            let (data, metadata) = try await URLSession.shared.upload(for: request, from: encodedDevice)
            
            let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
    
            return (decodedResponse,metadata as? HTTPURLResponse)
            
        } catch {
            print("Checkout failed.")
        }
        return(ApiResponse(info: "failed"),HTTPURLResponse())
        
    }
    
    
    //POST
    static func addOrUpdateNewDevice(path: String, email: String, device: Device) async throws -> (ApiResponse, HTTPURLResponse?) {
        
        let tempUrl = urlStr + path
        
        let ApiURL = URL(string: tempUrl)!
        
        let tempDevice = DeviceWithEmail(email: email, device: device)
        
        guard let encodedDevice = try? JSONEncoder().encode(tempDevice) else {
            throw "Can't create request!"
        }
        
        var request = URLRequest(url: ApiURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedDevice
        
        do {
            let (data, metadata) = try await URLSession.shared.upload(for: request, from: encodedDevice)
            
            let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
    
            return (decodedResponse,metadata as? HTTPURLResponse)
            
        } catch {
            print("Checkout failed.")
        }
        return(ApiResponse(info: "failed"),HTTPURLResponse())
        
    }
    
    //POST
    static func removeDevice(device: Device) async throws -> (ApiResponse, HTTPURLResponse?) {
        
        let tempUrl = urlStr + "removeDevice"
        
        let ApiURL = URL(string: tempUrl)!
        
        guard let encodedDevice = try? JSONEncoder().encode(device) else {
            throw "Can't create request!"
        }
        
        var request = URLRequest(url: ApiURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedDevice
        
        do {
            let (data, metadata) = try await URLSession.shared.upload(for: request, from: encodedDevice)
            
            let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
    
            return (decodedResponse,metadata as? HTTPURLResponse)
            
        } catch {
            print("Checkout failed.")
        }
        return(ApiResponse(info: "failed"),HTTPURLResponse())
        
    }
    
    //POST
    static func signInNewUser(account: Account) async throws -> (ApiResponse,HTTPURLResponse?) {
        
        let tempUrl = urlStr + "signin"
        
        let ApiURL = URL(string: tempUrl)!
        
        guard let encodedUser = try? JSONEncoder().encode(account) else {
            throw "Can't create request!"
        }
        
        var request = URLRequest(url: ApiURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedUser
        
        do {
            let (data, metadata) = try await URLSession.shared.upload(for: request, from: encodedUser)
            
            let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
    
            return (decodedResponse,metadata as? HTTPURLResponse)
            
        } catch {
            print("Checkout failed.")
        }
        return(ApiResponse(info: "failed"),HTTPURLResponse())
    }
}
