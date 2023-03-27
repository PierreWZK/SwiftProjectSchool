//
//  UIImage+Palette.swift
//  DOLIVETPierre
//
//  Created by Cours on 24/03/2023.
//

import UIKit

extension UIImage {
    
    var colorPalette: [UIColor]? {
        guard let ciImage = CIImage(image: self) else { return nil }
        
        let params = [kCIInputImageKey: ciImage, "inputCount": 8, "inputQuality": 0.5] as [String: Any]
        guard let ciFilter = CIFilter(name: "CIColorControls", parameters: params) else { return nil }
        guard let outputImage = ciFilter.outputImage else { return nil }
        
        let extent = outputImage.extent
        let bitmapInfo = CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
        guard let context = CGContext(data: nil, width: Int(extent.size.width), height: Int(extent.size.height), bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: bitmapInfo) else { return nil }
        
        let options = [CIContextOption.outputPremultiplied: true, CIContextOption.useSoftwareRenderer: false] as [CIContextOption : Any]
        guard let ciContext = CIContext(options: options) else { return nil }
        guard let cgImage = ciContext.createCGImage(outputImage, from: extent) else { return nil }
        
        context.draw(cgImage, in: extent)
        guard let pixelData = context.data else { return nil }
        
        var colorCounts: [UIColor: Int] = [:]
        
        let pointer = pixelData.bindMemory(to: UInt32.self, capacity: Int(extent.size.width * extent.size.height))
        let pixels = UnsafeBufferPointer(start: pointer, count: Int(extent.size.width * extent.size.height))
        
        for pixel in pixels {
            let r = CGFloat((pixel >> 16) & 0xff) / 255
            let g = CGFloat((pixel >> 8) & 0xff) / 255
            let b = CGFloat(pixel & 0xff) / 255
            
            let color = UIColor(red: r, green: g, blue: b, alpha: 1)
            if let count = colorCounts[color] {
                colorCounts[color] = count + 1
            } else {
                colorCounts[color] = 1
            }
        }
        
        let sortedColors = colorCounts.sorted { $0.value > $1.value }
        let colors = sortedColors.map { $0.key }
        
        return colors
    }
    
    func topTwoColors() -> (UIColor, UIColor)? {
        guard let colorPalette = self.colorPalette else {
            return nil
        }
        let sortedColors = colorPalette.sorted { $0.percentage > $1.percentage }
        if sortedColors.count >= 2 {
            let color1 = sortedColors[0].color
            let color2 = sortedColors[1].color
            return (color1, color2)
        }
        else if sortedColors.count == 1 {
            let color1 = sortedColors[0].color
            return (color1, .white)
        }
        else {
            return nil
        }
    }
}

// Example usage
if let image = UIImage(named: "myImage") {
    if let (color1, color2) = image.topTwoColors() {
        print("Top two colors: \(color1), \(color2)")
    }
}
