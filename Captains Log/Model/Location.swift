import Foundation
import CoreLocation
import Combine

enum LocationError: Error {
    case placemarkFailure
}

@MainActor class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    @Published var associatedPlacemark: CLPlacemark?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        
        // hopefully this is thread-safe
        Task {
            self.associatedPlacemark = try? await placemark(location: location)
        }
        
        print(#function, location)
    }
    
    /// Needs CoreLocation, asynchronously gives a placemark to a CLLocation.
    func placemark(location: CLLocation) async throws -> CLPlacemark {
        let geocoder = CLGeocoder()
        
        return try await withCheckedThrowingContinuation { continuation in
            
            var possibleLocations = [CLPlacemark]()
            
            geocoder.reverseGeocodeLocation(location) { (places, error) in
                guard let places = places else {
                    continuation.resume(throwing: LocationError.placemarkFailure)
                    return
                }
                
                for place in places {
                    possibleLocations.append(place)
                }
                
                if possibleLocations.count > 0 {
                    continuation.resume(returning: possibleLocations[0])
                }
                
            }
        }
    }
    
}
