//
//  File.swift
//  
//
//  Created by Tadreik Campbell on 10/15/21.
//

import UIKit

public struct Color {
    static public let dark = UIColor(red: 0, green: 0, blue: 0.1, alpha: 0.80)
    static public let accentColor = UIColor(red: 0.416, green: 0.106, blue: 0.604, alpha: 1)
    static public let secondaryColor = UIColor(red: 0.192, green: 0.914, blue: 0.878, alpha: 1)
    static public let tintedBackground = UIColor(red: 0.97, green: 0.978, blue: 1, alpha: 1)
}

public struct Font {
    static public let title = UIFont.systemFont(ofSize: 26, weight: .bold)
    static public let subtitle = UIFont.systemFont(ofSize: 19, weight: .medium)
    static public let body = UIFont.systemFont(ofSize: 16, weight: .regular)
    static public func number(size: CGFloat = 18, weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
}
