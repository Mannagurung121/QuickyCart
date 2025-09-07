import SwiftUI

struct PackageDetailView: View {
    var track: Tracker

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Package Detail")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top, 16)
                    .padding(.horizontal)

                Divider().background(Color.indigo)

                HStack {
                    Text("Package ID:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(track.trackingNumber ?? "Unknown Package")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .padding(.horizontal)

                Divider().background(Color.indigo)

                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("From")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(track.checkpoints?.last?.location ?? "N/A")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }

                    Spacer()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("To")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(track.checkpoints?.first?.location ?? "N/A")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }
                }
                .padding(.horizontal)

                Divider().background(Color.indigo)

                HStack {
                    Text("Delivery Partner:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(track.checkpoints?.first?.courierCode ?? "Unknown")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .padding(.horizontal)

                Divider().background(Color.indigo)

                HStack {
                    Text("Expected Arrival:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(DateFormatterHelper.formatExpectedDate(track.checkpoints?.first?.expectedDeliveryDate))
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .padding(.horizontal)

                Divider().background(Color.indigo)

                HStack(spacing: 8) {
                    Text("Live Status")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.indigo)
                    Image(systemName: "location.fill")
                        .foregroundColor(.indigo)
                }
                .padding(.horizontal)

                TimelineListView(timeline: track.checkpoints ?? [])
                    .padding(.horizontal)

                Spacer(minLength: 20)
            }
            .navigationTitle(Text("Details"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PackageDetailView(track: DummyData.dummyPackage)
}
