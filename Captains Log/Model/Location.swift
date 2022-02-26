import Foundation
import CoreLocation
import Combine

// Doesn't know what to do when no location is found

@MainActor // not sure if this is foolproof, or if it needs to be so general.
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation? {
        didSet {
            if let oldValue = oldValue {
                Task(priority: .high) {
                    do {
                        placemark = try await geocode(location: oldValue)[0]
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    @Published var placemark: CLPlacemark?

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
        print(#function, location)
    }
          
    
    // Rest of the class


    func geocode(location: CLLocation) async throws -> [CLPlacemark] {
        
        return await withCheckedContinuation { continuation in
            
            var possibleLocations = [CLPlacemark]()
            
            geocoder.reverseGeocodeLocation(location) { (places, error) in
                guard let places = places else {
                    return
                }
                
                for place in places {
                    possibleLocations.append(place)
                }
                
                if possibleLocations.count > 0 {
                    continuation.resume(returning: possibleLocations)
                }
                
            }
        }
    }
    
}
