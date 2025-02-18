//
//  Date+Ext.swift
//  Tutorial
//
//  Created by Apple on 17/02/25.
//

import Foundation

 extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
