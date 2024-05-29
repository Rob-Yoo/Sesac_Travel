//
//  RestaurantService.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/27/24.
//

import Foundation

final class RestaurantService {
    var restaurantList = RestaurantList().restaurantArray
    
    func search(query: String) -> [Restaurant] {
        var results = [Restaurant]()
        
        results = self.restaurantList.filter ({
            $0.name.contains(query) ||
            $0.address.contains(query) ||
            $0.category.contains(query)
        })
        
        return results
    }
    
    func updateStarData(id: Int) {
        guard let idx = self.restaurantList.firstIndex(where: {
            $0.id == id
        }) else { return }
        
        self.restaurantList[idx].isStar.toggle()
    }
}
