import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.ship24.com/public/v1/trackers"
    private init() {}

    func trackShipment(trackingNumber: String,
                       completion: @escaping (Result<Tracker, ErrorHandler>) -> Void) {
        createAndFetchTracker(trackingNumber: trackingNumber, completion: completion)
    }

    private func createAndFetchTracker(trackingNumber: String,
                                       completion: @escaping (Result<Tracker, ErrorHandler>) -> Void) {

        guard let url = URL(string: "\(baseURL)/track") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(ApiConfig.apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["trackingNumber": trackingNumber]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.invalidResponse))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode),
                  let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(Ship24Response.self, from: data)
                if let firstTracking = decoded.data.trackings.first {
                    let tracker = firstTracking.toTracker() //  this maps to Tracker
                    completion(.success(tracker))
                } else {
                    completion(.failure(.invalidData))
                }
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
}
