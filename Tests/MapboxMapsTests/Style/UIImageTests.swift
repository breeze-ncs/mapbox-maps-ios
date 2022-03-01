import XCTest
import UIKit
@testable import MapboxMaps
@_implementationOnly import MapboxCoreMaps_Private

class UIImageTests: XCTestCase {

    func createWithUIGraphicsContxtForWidth(width: Int, height: Int) -> UIImage {
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5).setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let generated = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return generated!

    }

    func createWithCGContextForWidth(width: Int, height: Int) -> UIImage {
        return creatWithCGContextForWidth(width: width, height: height, flags:  CGImageAlphaInfo.premultipliedLast.rawValue)
    }

    func creatWithCGContextForWidth(width: Int, height: Int, flags: UInt32) -> UIImage {
        let scaleFactor = Int(UIScreen.main.scale)
        let scaledWidth = width * scaleFactor
        let scaledHeight = height * scaleFactor
        let bitsPerComponent = 8
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * Int(scaledWidth)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: 0 | flags)

        let components: [CGFloat] = [0.0, 1.0, 0.0, 0.5]

        context?.setFillColorSpace(colorSpace)
        context?.setFillColor(components)
        context?.fill(CGRect(x: 0, y: 0, width: scaledWidth, height: scaledHeight))
        let image = UIImage.init(cgImage: (context?.makeImage())!, scale: CGFloat(scaleFactor), orientation: UIImage.Orientation.up)
        return image

    }

    func testConvertGeneratedARGBUIImage() {
        let uiImage = createWithUIGraphicsContxtForWidth(width: 1, height: 1)
        let mbxImage = Image(uiImage: uiImage)
        XCTAssert((mbxImage != nil), "Failed to convert UIImage to MBXImage")
    }

    func testConvertGeneratedRGBAUIImage() {
        let uiImage = createWithCGContextForWidth(width: 1, height: 1)
        let mbxImage = Image(uiImage: uiImage)
        XCTAssert((mbxImage != nil), "Failed to convert UIImage to MBXImage")
    }

    func testConvertGeneratedRGBXUIImage() {
        let uiImage = creatWithCGContextForWidth(width: 1, height: 1, flags: CGImageAlphaInfo.noneSkipLast.rawValue)
        let mbxImage = Image(uiImage: uiImage)
        XCTAssert((mbxImage != nil), "Failed to convert UIImage to MBXImage")
    }

    func testConvertGeneratedXRGBUIImage() {
        let uiImage = creatWithCGContextForWidth(width: 1, height: 1, flags:  CGImageAlphaInfo.noneSkipFirst.rawValue)
        let mbxImage = Image(uiImage: uiImage)
        XCTAssert((mbxImage != nil), "Failed to convert UIImage to MBXImage")
    }
}
