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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureFilterBarButton()
        self.configureMapView()
    }
    
}

// MARK: - Configure Subviews
extension RestaurantMapViewController {
    private func configureFilterBarButton() {
        let filterBarButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(filterBarButtonTapped))
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = filterBarButton
    }
    
    private func configureMapView() {
        let pos = CLLocationCoordinate2D(latitude: 37.51791, longitude: 126.88655)
        
        self.mapView.region = MKCoordinateRegion(center: pos, latitudinalMeters: 1000, longitudinalMeters: 1000)
        filteredRestaurantList.forEach {
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

