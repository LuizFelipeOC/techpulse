//
//  String+Ext.swift
//  techpulse
//
//  Created by Luiz Felipe on 01/07/26.
//

import Foundation
import UIKit

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
    
        func toMarkdownAttributedString(fontSize: CGFloat = 18, textColor: UIColor = .label, completion: @escaping (NSAttributedString) -> Void) {
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let options = AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
                    var attributedString = try AttributedString(markdown: self, options: options)
                    
                    var container = AttributeContainer()
                    container.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
                    container.foregroundColor = textColor
                    attributedString.mergeAttributes(container, mergePolicy: .keepCurrent)
                    
                    let finalString = NSAttributedString(attributedString)
                    
                    DispatchQueue.main.async {
                        completion(finalString)
                    }
                } catch {
                    print("Erro ao renderizar Markdown: \(error)")
                    let fallbackString = NSAttributedString(string: self)
                    DispatchQueue.main.async {
                        completion(fallbackString)
                    }
                }
            }
        }
}
