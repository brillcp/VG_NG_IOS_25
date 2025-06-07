//
//  UIColor.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import UIKit
import SwiftUI

extension Color {
    var isDark: Bool {
        UIColor(self).isDark
    }
}
extension UIColor {
    var isDark: Bool {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return false }

        let luminance = 0.299 * red + 0.587 * green + 0.114 * blue
        return luminance < 0.8
    }
}
