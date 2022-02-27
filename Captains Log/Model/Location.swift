import Foundation
import CoreLocation
import Combine

@MainActor // not sure if this is foolproof, or if it needs to be so general.
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation? {
        // Code that updates associatedPlacemark
        willSet {
            if let newValue = newValue {
                Task(priority: .high) {
                    do {
                        associatedPlacemark = try await placemark(location: newValue)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
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
        print(#function, location)
    }
    
}

/// Needs CoreLocation, asynchronously gives a placemark to a CLLocation.
func placemark(location: CLLocation) async throws -> CLPlacemark {
    let geocoder = CLGeocoder()
    
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
                continuation.resume(returning: possibleLocations[0])
            }
            
        }
    }
}

//func recognize(request: SFSpeechURLRecognitionRequest, with recognizer: SFSpeechRecognizer) async throws -> [SFSpeechRecognitionResult] {
//
//    // took away return
//    return await withCheckedContinuation { continuation in
//
//        var draft = [SFSpeechRecognitionResult]()
//
//        recognizer.recognitionTask(with: request) { (result, error) in
//            guard let result = result else {
//                print("ERROR: \(error!)")
//                // should be throwing...
//                return
//            }
//
//            draft.append(result)
//
//            if result.isFinal {
//                continuation.resume(returning: draft)
//            }
//        }
//    }
//}
