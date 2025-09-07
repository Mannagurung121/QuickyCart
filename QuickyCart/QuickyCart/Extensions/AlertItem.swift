//
//  AlertItem.swift
//  QuickyCart
//
//  Created by Manan Gurung on 14/07/25.
//

import Foundation
import SwiftUICore
import SwiftUI
struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}




struct AlertContext {
    static let invalidURL = AlertItem(title: Text( "Invalid URL"),
                                              message: Text("The URL provided is not valid. Please try again later."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidData = AlertItem(title: Text("Invalid Data"),
                                              message: Text("The data received from the server was not valid."),
                                              dismissButton: .default(Text("OK")))

    static let invalidResponse = AlertItem(title: Text("Invalid Response"),
                                              message: Text("The server response was not what we expected."),
                                              dismissButton: .default(Text("OK")))
    
}
