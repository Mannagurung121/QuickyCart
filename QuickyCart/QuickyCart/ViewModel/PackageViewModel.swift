
import Foundation

final class PackageViewModel: ObservableObject {
    @Published var tracker: Tracker? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    func fetchPackage(trackingNumber: String, completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        self.errorMessage = nil

        NetworkManager.shared.trackShipment(trackingNumber: trackingNumber) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let trackerData):
                    print(" Package found: \(trackerData.trackingNumber ?? "N/A")")
                    self?.tracker = trackerData
                    completion(true)
                case .failure(let error):
                    print(" Failed to fetch package: \(error.localizedDescription)")
                    self?.tracker = nil
                    self?.errorMessage = "Unable to fetch package details. Please try again."
                    completion(false)
                }
            }
        }
    }
}
