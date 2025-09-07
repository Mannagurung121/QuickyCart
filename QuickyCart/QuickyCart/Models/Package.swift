import Foundation

// MARK: - POST Response Models
struct RegisterTrackerResponse: Codable {
    let data: RegisterData
}

struct RegisterData: Codable {
    let tracker: RegisterTracker
}

struct RegisterTracker: Codable {
    let trackerId: String
    let trackingNumber: String?
    let shipmentReference: String?
    let courierCode: [String]?
    let clientTrackerId: String?
    let isSubscribed: Bool?
    let isTracked: Bool?
    let createdAt: String?
}

// MARK: - GET Response Models
struct Ship24Response: Codable {
    let data: TrackerData
}

struct TrackerData: Codable {
    let trackings: [TrackingItem]
}

// MARK: - ❌ NO NEED TO USE THIS DIRECTLY NOW
// Instead of TrackingItem, we extract and transform data into Tracker
struct TrackingItem: Codable {
    let tracker: Tracker
    let shipment: Shipment?
    let events: [Event]?
    let statistics: Statistics?
}

//  UPDATED Tracker Model to include shipment info directly
struct Tracker: Codable {
    let trackingNumber: String?
    let carrierCode: String?
    let createdAt: String?
    var checkpoints: [Checkpoint]?
    let status: String?
    let lastUpdated: String?
    let trackerId: String?

    // e new properties
    let statusMilestone: String?
    let statusCategory: String?
    let estimatedDeliveryDate: String?
}

// Shipment Model
struct Shipment: Codable {
    let shipmentId: String
    let statusCode: String?
    let statusCategory: String?
    let statusMilestone: String?
    let originCountryCode: String?
    let destinationCountryCode: String?
    let delivery: Delivery?
    let trackingNumbers: [TrackingNumber]?
    let recipient: Recipient?
}

struct Delivery: Codable {
    let estimatedDeliveryDate: String?
    let service: String?
    let signedBy: String?
}

struct TrackingNumber: Codable {
    let tn: String?
}

struct Recipient: Codable {
    let name: String?
    let address: String?
    let postCode: String?
    let city: String?
    let subdivision: String?
}

struct Event: Codable {
    let eventId: String?
    let trackingNumber: String?
    let eventTrackingNumber: String?
    let status: String?
    let occurrenceDatetime: String?
    let datetime: String?
    let hasNoTime: Bool?
    let utcOffset: String?
    let location: String?
    let sourceCode: String?
    let courierCode: String?
    let statusCode: String?
    let statusCategory: String?
    let statusMilestone: String?
}

struct Statistics: Codable {
    let timestamps: Timestamps?
}

struct Timestamps: Codable {
    let infoReceivedDatetime: String?
    let inTransitDatetime: String?
    let outForDeliveryDatetime: String?
    let failedAttemptDatetime: String?
    let availableForPickupDatetime: String?
    let exceptionDatetime: String?
    let deliveredDatetime: String?
}

// Checkpoint Model 
struct Checkpoint: Codable {
    let location: String?
    let status: String?
    let description: String?
    let checkpointTime: String?
    let courierCode: String?
    let expectedDeliveryDate: String?

    init(location: String?,
         status: String?,
         description: String?,
         checkpointTime: String?,
         courierCode: String?,
         expectedDeliveryDate: String?) {
        self.location = location
        self.status = status
        self.description = description
        self.checkpointTime = checkpointTime
        self.courierCode = courierCode
        self.expectedDeliveryDate = expectedDeliveryDate
    }
}

struct CheckpointResponse: Codable {
    let data: CheckpointData
}

struct CheckpointData: Codable {
    let checkpoints: [Checkpoint]
}
