//
//  TrackingListView.swift
//  QuickyCart
//
//  Created by Manan Gurung on 02/08/25.
//




import SwiftUI

struct TrackingListView: View {
    @State private var trackers: [Tracker] = []

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    if trackers.isEmpty {
                        VStack(spacing: 8) {
                            Image(systemName: "shippingbox")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                            Text("No active packages.")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        }
                        .padding(.top, 100)
                    } else {
                        ForEach(trackers, id: \.trackerId) { track in
                            NavigationLink(destination: PackageDetailView(track: track)) {
                                TrackingCardView(track: track) {
                                    deleteTracker(track)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("My Packages")
            .onAppear {
                loadTrackers()
            }
        }
    }

   
    func deleteTracker(_ tracker: Tracker) {
        SavedTrackManager.shared.remove(tracker)
        loadTrackers()
    }

    func loadTrackers() {
        trackers = SavedTrackManager.shared.getAll().filter {
            ($0.statusMilestone?.lowercased() ?? "") != "delivered"
        }
    }
}

#Preview {
    TrackingListView()
}
