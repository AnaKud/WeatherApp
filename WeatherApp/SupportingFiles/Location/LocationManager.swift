// LocationManager.swift
// Created by Anastasiya Kudasheva

import Foundation
import CoreLocation

protocol ILocationManager: AnyObject {
	var handleDelegateResult: ((Result<CLLocation, LocationError>) -> Void)? { get set }

	func getCurrentLocation(completion: @escaping ((Result<CLLocation, LocationError>) -> Void))
	func getLocation(for place: String,
					 completion: @escaping ((Result<CLLocation, LocationError>) -> Void))
}

class LocationManager: NSObject {
	var handleDelegateResult: ((Result<CLLocation, LocationError>) -> Void)?


	private let locationManager = CLLocationManager()
	private let geocoder = CLGeocoder()

	override init() {
		super.init()
		self.locationManager.delegate = self
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
		self.locationManager.requestWhenInUseAuthorization()
	}
}


// MARK: - Core Location Delegate
extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager,
						 didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .notDetermined:
			self.locationManager.requestWhenInUseAuthorization()
		case .authorizedWhenInUse, .authorizedAlways:
			guard let handleDelegateResult else { return }
			self.getCurrentLocation(completion: handleDelegateResult)
		case .restricted, .denied:
			self.handleDelegateResult?(.failure(.noPermission))
		@unknown default:
			self.handleDelegateResult?(.failure(.noPermission))
		}
	}
}

// MARK: - Get Placemark
extension LocationManager: ILocationManager {
	func getCurrentLocation(completion: @escaping ((Result<CLLocation, LocationError>) -> Void)) {
		guard self.locationManager.authorizationStatus != .notDetermined else { return }

		guard self.locationManager.authorizationStatus != .denied,
			  self.locationManager.authorizationStatus != .restricted else {
			completion(.failure(.noPermission))
			return
		}

		guard let location = self.locationManager.location else {
			completion(.failure(.detectionFailed))
			return
		}
		self.geocoder.reverseGeocodeLocation(location) { placemarks, error in
			guard error == nil,
				  let location = placemarks?[0].location else {
				completion(.failure(.detectionFailed))
				return
			}

			completion(.success(location))
		}
	}

	func getLocationName(completion: @escaping ((Result<String, LocationError>) -> Void)) {
		guard let location = self.locationManager.location else {
			completion(.failure(.detectionFailed))
			return
		}
		self.geocoder.reverseGeocodeLocation(location) { placemarks, error in
			guard error == nil,
				  let locationName = placemarks?[0].name else {
				completion(.failure(.detectionFailed))
				return
			}

			completion(.success(locationName))
		}
	}

	func getLocation(for place: String,
					 completion: @escaping ((Result<CLLocation, LocationError>) -> Void)) {
		self.geocoder.geocodeAddressString(place) { placemarks, error in

			guard error == nil,
				  let placemark = placemarks?[0],
				  let location = placemark.location else {
				completion(.failure(.detectionFailed))
				return
			}

			completion(.success(location))
		}
	}
}
