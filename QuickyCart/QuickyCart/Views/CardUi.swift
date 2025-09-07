import SwiftUI

struct TrackingCardView: View {
    var track: Tracker
    var onDelete: (() -> Void)? = nil  //Optional delete handler

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

          
            HStack(alignment: .top) {
                Text(track.trackingNumber ?? "Unknown ID")
                    .font(.headline)
                    .foregroundColor(.brandPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                Spacer()

                let milestone = track.statusMilestone?.lowercased() ?? ""
                let badgeColor: Color = {
                    switch milestone {
                    case "delivered":
                        return .green
                    case "out_for_delivery":
                        return .orange
                    default:
                        return .blue
                    }
                }()

                HStack(spacing: 6) {
                    Text(track.statusMilestone?.replacingOccurrences(of: "_", with: " ").capitalized
                         ?? track.status ?? "In Transit")
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(badgeColor.opacity(0.1))
                        .foregroundColor(badgeColor)
                        .clipShape(Capsule())
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)

                    if let onDelete = onDelete {
                        Button(action: onDelete) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red.opacity(0.7))
                        }
                    }
                }
            }

            Divider()

            //  FROM | TO | ETA (Responsive layout for long city names)
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("From")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(track.checkpoints?.last?.location ?? "N/A")
                        .font(.footnote)
                        .fontWeight(.medium)
                        .lineLimit(2)
                        .minimumScaleFactor(0.7)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 2) {
                    Text("To")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(track.checkpoints?.first?.location ?? "N/A")
                        .font(.footnote)
                        .fontWeight(.medium)
                        .lineLimit(2)
                        .minimumScaleFactor(0.7)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .trailing, spacing: 2) {
                    Text("ETA")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(DateFormatterHelper.formatExpectedDate(track.estimatedDeliveryDate))
                        .font(.footnote)
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }

            // Last Updated
            Text("Last updated: \(DateFormatterHelper.formatExpectedDate(track.lastUpdated ?? ""))")
                .font(.caption2)
                .foregroundColor(.secondary)
                .padding(.top, 6)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 6)
        )
        .padding(.horizontal)
    }
}

#Preview {
    TrackingCardView(track: DummyData.dummyPackage)
}
