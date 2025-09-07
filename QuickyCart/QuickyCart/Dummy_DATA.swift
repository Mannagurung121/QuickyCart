//
//  DummyData.swift
//  QuickyCart
//
//  Created by Manan Gurung on 27/07/25.
//

//
//  DummyData.swift
//  QuickyCart
//
//  Created by Manan Gurung on 27/07/25.
//

import Foundation

struct DummyData {
    static let dummyPackage = Tracker(
        trackingNumber: "FMPP3211543380",
        carrierCode: "Delhivery",
        createdAt: "2025-07-27T05:51:39Z",
        checkpoints: [
            Checkpoint(
                location: "Delhi",
                status: "Out for Delivery",
                description: "Package is on the way",
                checkpointTime: "2025-07-27T06:00:00Z",
                courierCode: "BlueDart",
                expectedDeliveryDate: "2025-07-29T14:00:00Z"
            ),
            Checkpoint(
                location: "Mumbai",
                status: "In Transit",
                description: "Package left hub",
                checkpointTime: "2025-07-25T14:00:00Z",
                courierCode: "BlueDart",
                expectedDeliveryDate: "2025-07-29T14:00:00Z"
            )
        ],
        status: "In Transit",
        lastUpdated: "2025-07-27T06:00:00Z",
        trackerId: "dummy-id-123",
        
 
        statusMilestone: "in_transit",
        statusCategory: "delivery",
        estimatedDeliveryDate: "2025-07-29T14:00:00Z"
    )
}
