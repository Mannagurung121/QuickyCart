import Foundation
import SwiftUI


struct ApiConfig {
    static let apiKey: String = {
        if let key = Bundle.main.object(forInfoDictionaryKey: "SHIP24_API_KEY") as? String {
            print(" Loaded API Key: \(key)")
            return key
        } else {
            fatalError(" API Key is missing in Info.plist")
        }
    }()
}
