//extension Array where Element == ShipmentRawStatus {
//    func groupShipments() -> [ShipmentTrack] {
//        let grouped = Dictionary(grouping: self, by: { $0.packageID })
//
//        return grouped.map { (_, rawStatuses) in
//            guard let first = rawStatuses.first else { fatalError() }
//
//            let timeline = rawStatuses.map { status in
//                ShipmentStatus(
//                    date: status.date,
//                    status: status.status,
//                    description: status.description,
//                    isCompleted: status.isCompleted
//                )
//            }.sorted { $0.date > $1.date } // Descending: latest first
//
//            return ShipmentTrack(
//                packageID: first.packageID,
//                fromAddress: first.fromAddress,
//                toAddress: first.toAddress,
//                deliveryPartner: first.deliveryPartner,
//                lastKnownLocation: first.lastKnownLocation,
//                timeline: timeline,
//                isCompleted: timeline.first?.isCompleted ?? false,
//            )
//        }
//    }
//}
import Foundation

extension TrackingItem {
    func toTracker() -> Tracker {
        let checkpoints = (self.events ?? []).map { event in
            Checkpoint(
                location: event.location,
                status: event.status,
                description: event.status,
                checkpointTime: event.datetime ?? event.occurrenceDatetime,
                courierCode: event.courierCode,
                expectedDeliveryDate: self.shipment?.delivery?.estimatedDeliveryDate
            )
        }

        return Tracker(
            trackingNumber: tracker.trackingNumber,
            carrierCode: tracker.carrierCode,
            createdAt: tracker.createdAt,
            checkpoints: tracker.checkpoints ?? checkpoints,
            status: tracker.status,
            lastUpdated: tracker.lastUpdated,
            trackerId: tracker.trackerId,

            //  enrich from shipment
            statusMilestone: shipment?.statusMilestone,
            statusCategory: shipment?.statusCategory,
            estimatedDeliveryDate: shipment?.delivery?.estimatedDeliveryDate
        )
    }
}
