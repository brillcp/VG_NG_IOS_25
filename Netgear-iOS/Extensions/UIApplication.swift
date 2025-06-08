//
//  UIApplication.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-08.
//

import UIKit

extension UIApplication {
    var statusBarHeight: CGFloat {
        guard let windowScene = connectedScenes.first as? UIWindowScene,
              let window = windowScene.keyWindow
        else { return 0 }
        return window.safeAreaInsets.top + 44
    }
}
