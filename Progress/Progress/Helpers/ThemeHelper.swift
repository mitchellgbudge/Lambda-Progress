//
//  ThemeHelper.swift
//  Progress
//
//  Created by Mitchell Budge on 11/21/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

enum ThemeHelper {
    static var lambdaGrey = UIColor(red:0.33, green:0.35, blue:0.43, alpha:0.5)
    static var lambdaLightBlue = UIColor(red:0.23, green:0.71, blue:0.90, alpha:1.0)
    static var lambdaBlue = UIColor(red:0.10, green:0.38, blue:0.69, alpha:1.0)
    static var lambdaDarkBlue = UIColor(red:0.05, green:0.24, blue:0.47, alpha:1.0)
    static var lambdaRed = UIColor(red:0.73, green:0.07, blue:0.20, alpha:0.7)
    
    static let textAttributes = [NSAttributedString.Key.foregroundColor: ThemeHelper.lambdaGrey, NSAttributedString.Key.font: UIFont(name: "Lato", size: 20)]
    
    static func latoFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        let font = UIFont(name: "Lato", size: pointSize)!
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
    }
    
    static func setTheme() {
        
    
        
    }
}
