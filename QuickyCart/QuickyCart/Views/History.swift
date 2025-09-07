//
//  History.swift
//  QuickyCart
//
//  Created by Manan Gurung on 02/08/25.
//

import SwiftUI

struct HistoryView: View {
    @State private var deliveredTrackers: [Tracker] = []

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(deliveredTrackers, id: \.trackerId) { track in
                        NavigationLink(destination: PackageDetailView(track: track)) {
                            TrackingCardView(track: track)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    if deliveredTrackers.isEmpty {
                        Spacer()
                        VStack(spacing: 8) {
                            Image(systemName: "paperplane")
                                .font(.system(size: 40))
                                .foregroundColor(.green)
                            Text("No delivered packages yet.")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        }
                        .padding(.top, 40)
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Delivery History")
        }
        .onAppear {
            let all = SavedTrackManager.shared.getAll()
            
            deliveredTrackers = all.filter { ($0.statusMilestone?.lowercased() ?? "") == "delivered" }
                
        }
    }
}

#Preview {
    HistoryView()
}
