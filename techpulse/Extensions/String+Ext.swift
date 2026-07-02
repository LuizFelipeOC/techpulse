//
//  String+Ext.swift
//  techpulse
//
//  Created by Luiz Felipe on 01/07/26.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.locale = Locale(identifier: "pt_BR")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            return dateFormatter.date(from: self)
        }
        
        func convertToDisplayFormat() -> String {
            guard let date = self.convertToDate() else { return "Data indisponível" }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.locale = Locale(identifier: "pt_BR")
            
            return dateFormatter.string(from: date)
        }
        
        func convertToRelativeTime() -> String {
            guard let date = self.convertToDate() else { return "" }
            
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            formatter.locale = Locale(identifier: "pt_BR")
            
            return formatter.localizedString(for: date, relativeTo: Date())
        }
}
