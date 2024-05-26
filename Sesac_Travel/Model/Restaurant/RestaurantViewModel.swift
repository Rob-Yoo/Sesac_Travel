//
//  RestaurantViewModel.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/26/24.
//

import Foundation

class RestaurantViewModel {
    lazy var output = self.service.restaurantList {
        didSet {
            NotificationCenter.default.post(name: .RestaurantModelChanged, object: nil)
        }
    }
    private var service = RestaurantService()
    
    func fetchSearchedRestaurants(query: String) {
        if (query.isEmpty) {
            self.output = service.restaurantList
        } else {
            self.output = service.search(query: query)
        }
    }
    
    func updateIsStar(idx: Int, id: Int) {
        self.service.updateStarData(id: id)
        self.output[idx].isStar.toggle()
    }
}


