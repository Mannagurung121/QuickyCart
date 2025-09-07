//
//  DateFormatter.swift
//  QuickyCart
//
//  Created by Manan Gurung on 23/07/25.
//



import Foundation

struct DateFormatterHelper {
    static func formatExpectedDate(_ isoDate: String?) -> String {
        guard let isoDate = isoDate else { return "N/A" }
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // Add this
        if let date = formatter.date(from: isoDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .none
            return displayFormatter.string(from: date)
        }
        return "N/A"
    }
}
