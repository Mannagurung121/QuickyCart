//
//  LocalStorage.swift
//  QuickyCart
//
//  Created by Manan Gurung on 02/08/25.
//

import Foundation

class SavedTrackManager {
    static let shared = SavedTrackManager()

    private let key = "savedTrackers"

    func save(_ tracker: Tracker) {
        var existing = load()
        if !existing.contains(where: { $0.trackingNumber == tracker.trackingNumber }) {
            existing.insert(tracker, at: 0)
            if let encoded = try? JSONEncoder().encode(existing) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }

    func load() -> [Tracker] {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Tracker].self, from: data) {
            return decoded
        }
        return []
    }

    func getAll() -> [Tracker] {
            guard let data = UserDefaults.standard.data(forKey: key),
                  let trackers = try? JSONDecoder().decode([Tracker].self, from: data) else {
                return []
            }
            return trackers
        }
    
//
    func remove(_ tracker: Tracker) {
        var existing = load()
        existing.removeAll { $0.trackingNumber == tracker.trackingNumber }
        if let encoded = try? JSONEncoder().encode(existing) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func clearAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
