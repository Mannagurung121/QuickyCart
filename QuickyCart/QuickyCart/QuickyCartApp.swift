//
//  QuickyCartApp.swift
//  QuickyCart
//
//  Created by Manan Gurung on 09/07/25.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseMessaging
import UserNotifications
import UIKit
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate{
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        
        
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print(" Permission aLLOWED: \(granted)")
        }
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        return true
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // 6. Called when FCM registration token is updated
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("📱 FCM Token: \(fcmToken ?? "")")
        // 🔄 You can send this token to your Node.js backend to send notifications
    }
    
    
}
@main
struct QuickyCartApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


    init() {
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                QuickyCartMain()
            }
        }
    }
}
