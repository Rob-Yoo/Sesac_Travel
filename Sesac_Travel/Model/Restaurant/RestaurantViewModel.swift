//
//  RestaurantViewModel.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/26/24.
//

import Foundation
//        transform
// Intput -------------> Output
final class RestaurantViewModel {
    lazy var restaurantList: Observable<[Restaurant]> = Observable(self.service.restaurantList)
    private var service = RestaurantService()
    
    func fetchSearchedRestaurants(query: String) {
        if (query.isEmpty) {
            self.restaurantList.value = service.restaurantList
        } else {
            self.restaurantList.value = service.search(query: query)
        }
    }
//    
    func updateIsStar(idx: Int, id: Int) {
        self.service.updateStarData(id: id)
        self.restaurantList.value[idx].isStar.toggle()
    }
    
    func restaurantListDidChange(restaurantList list: [Restaurant]) {
        self.restaurantList.value = list
    }
}


