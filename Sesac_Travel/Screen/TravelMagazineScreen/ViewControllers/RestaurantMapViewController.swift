//
//  RestaurantMapViewController.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/30/24.
//

import UIKit
import MapKit

class RestaurantMapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!

    private let rawRestaurantList: [Restaurant] = RestaurantList().restaurantArray
    private lazy var filteredRestaurantList: [Restaurant] = self.rawRestaurantList
    private let locationManger = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManger.delegate = self
        self.configureFilterBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkLocationAuthorization()
    }
}

//MARK: - CLLocationManger
extension RestaurantMapViewController: CLLocationManagerDelegate {
    
    private func checkLocationAuthorization() {
        DispatchQueue.global().async {
            let isEnabled = CLLocationManager.locationServicesEnabled()
                
            if (isEnabled) {
                let status = self.locationManger.authorizationStatus
                
                DispatchQueue.main.async {
                    switch status {
                    case .notDetermined: // 아직 위치 서비스 권한 설정에 대한 선택이 되지 않은 경우
                        self.locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters
                        self.locationManger.requestWhenInUseAuthorization()
                    case .denied: // 거부한 경우
                        let alert = UIAlertController.makeLocationSettingAlert()
                        
                        self.configureMapView()
                        self.present(alert, animated: true)
                    case .authorizedWhenInUse:
                        self.locationManger.startUpdatingLocation()
                    default:
                        return
                    }
                }
                
            } else {
                self.configureMapView()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            self.configureMapView(center: coordinate)
        }
        
        self.locationManger.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.checkLocationAuthorization()
    }
}

// MARK: - Configure Subviews
extension RestaurantMapViewController {
    private func configureFilterBarButton() {
        let filterBarButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(filterBarButtonTapped))
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = filterBarButton
    }
    
    private func configureMapView(center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.51791, longitude: 126.88655)) {

        self.mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.configureRestaurantMarkers()
    }
    
    private func configureRestaurantMarkers() {
        self.filteredRestaurantList.forEach {
            let (lat, lon) = ($0.latitude, $0.longitude)
            let pos = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = pos
            annotation.title = $0.name
            mapView.addAnnotation(annotation)
        }
    }
}

//MARK: - User Action Handling
extension RestaurantMapViewController {
    @objc private func filterBarButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let all = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.filteredRestaurantList = self.rawRestaurantList
            self.configureMapView()
        }
    
        ["한식", "중식", "일식", "양식", "카페"].forEach {
            let action = UIAlertAction(title: $0, style: .default) { ac in
                self.filterRestaurantList(foodType: ac.title ?? "")
            }
            
            alert.addAction(action)
        }
        
        alert.addAction(all)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
}

//MARK: - Presentaion Logic
extension RestaurantMapViewController {
    private func filterRestaurantList(foodType: String) {
        self.filteredRestaurantList = self.rawRestaurantList.filter { $0.category == foodType }
        self.mapView.removeAnnotations(mapView.annotations)
        self.configureMapView()
    }
}

