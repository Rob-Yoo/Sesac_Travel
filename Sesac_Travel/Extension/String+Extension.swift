//
//  String+Extension.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/26/24.
//

import Foundation

extension String {
    func formatDate(inputDateFormat: String, outputDateFormat: String) -> String? {
        let inputFormatter = DateFormatter()
        let outputFormatter = DateFormatter()
        
        inputFormatter.dateFormat = inputDateFormat
        
        guard let dateString = inputFormatter.date(from: self) else {
            return nil
        }
        
        outputFormatter.dateFormat = outputDateFormat
        return outputFormatter.string(from: dateString)
    }
}
