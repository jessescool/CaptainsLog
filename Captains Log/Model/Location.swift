//import CoreLocation
//
//class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
//    @Published var authorizationStatus: CLAuthorizationStatus
//
//    private let locationManager: CLLocationManager
//
//    override init() {
//        locationManager = CLLocationManager()
//        authorizationStatus = locationManager.authorizationStatus
//
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startUpdatingLocation()
//    }
//
//    func requestPermission() {
//        locationManager.requestWhenInUseAuthorization()
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        authorizationStatus = manager.authorizationStatus
//    }
//}

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation? {
        didSet {
            if let oldValue = oldValue {
                Task(priority: .background) {
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
    
//    var placemarks: [CLPlacemark] = await geocode(location: lastLocation!)
}

//func recognize(request: SFSpeechURLRecognitionRequest, with recognizer: SFSpeechRecognizer) async throws -> [SFSpeechRecognitionResult] {
//
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
