//
//  UIImage.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import Foundation
import SwiftUI

extension UIImage {
    func averageColor() -> Color? {
        guard let inputImage = CIImage(image: self) else { return nil }

        let extent = inputImage.extent
        let context = CIContext(options: [.workingColorSpace: NSNull()])
        let filter = CIFilter(name: "CIAreaAverage", parameters: [
            kCIInputImageKey: inputImage,
            kCIInputExtentKey: CIVector(cgRect: extent)
        ])!

        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)

        return Color(
            red: Double(bitmap[0]) / 255.0,
            green: Double(bitmap[1]) / 255.0,
            blue: Double(bitmap[2]) / 255.0
        )
    }
}
