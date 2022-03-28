//
//  Extension.swift
//  Hilmyghozy
//
//  Created by hilmy ghozy on 28/03/22.
//

import Foundation
import UIKit

extension UIColor {
    static let fontColor = UIColor(named: "font")
    static let red = UIColor(named: "red")
    static let green = UIColor(named: "green")
    static let gray = UIColor(named: "gray")
    static let background = UIColor(named: "background")
}

extension String {
    
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
    
    func reset() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        return attributeString
    }
}
extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        // formatter.locale = Locale(identifier: Localify.shared.languageIdentifier)
        formatter.dateFormat = format
        let stringDate = formatter.string(from: self)
        
        return stringDate
    }
}
