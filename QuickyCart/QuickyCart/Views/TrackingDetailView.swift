//
//  TrackingDetailView.swift
//  QuickyCart
//
//  Created by Manan Gurung on 11/07/25.
//

import SwiftUI

struct TimelineListView: View {
    let timeline: [Checkpoint]

    var body: some View {
        if timeline.isEmpty {
            VStack {
                Image(systemName: "shippingbox")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                Text("No tracking events yet.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List {
                ForEach(Array(timeline.enumerated()), id: \.offset) { index, step in
                    HStack(alignment: .top, spacing: 8) {
                        VStack {
                            Circle()
                                .fill(index == 0 ? Color.blue : Color.gray)
                                .frame(width: 12, height: 12)
                                .overlay(
                                    index == 0
                                    ? AnyView(
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 6))
                                            .foregroundColor(.white)
                                    )
                                    : AnyView(EmptyView())
                                )

                            if index != timeline.count - 1 {
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(width: 2)
                                    .frame(maxHeight: .infinity)
                            }
                        }

                        VStack(alignment: .leading, spacing: 2) {
                            Text(DateFormatterHelper.formatExpectedDate(step.checkpointTime ?? ""))
                                .font(.caption2)
                                .foregroundColor(.gray)

                            Text(step.status ?? "Status unavailable")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(index == 0 ? .blue : .primary)

                            Text(step.description ?? "No details available")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .listStyle(.plain)
        }
    }
}
//#Preview {
//    
//    TimelineListView(timeline: DummyData.dummyPackage.checkpoints ?? [])
//}
