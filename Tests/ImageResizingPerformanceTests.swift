import XCTest
import UIKit
@testable import Image_Resizing

class ImageResizingPerformanceTests: XCTestCase {
    let size = CGSize(width: 100.0, height: 100.0)

    let url = Bundle.main.url(forResource: "VIIRS_3Feb2012_lrg",
                              withExtension: "jpg")!

    func testPerformanceCoreGraphics() {
        var image: UIImage?
        
        self.measure {
            image = CoreGraphics.resizedImage(at: url, for: size)
        }
        
        XCTAssertNotNil(image)
        XCTAssertEqual(image!.size.width, size.width, accuracy: 0.001)
        XCTAssertEqual(image!.size.height, size.height, accuracy: 0.001)
    }
    
    func testPerformanceCoreImage() {
        var image: UIImage?
        
        self.measure {
            image = CoreImage.resizedImage(at: url, for: size)
        }
        
        XCTAssertNotNil(image)
        XCTAssertEqual(image!.size.width, size.width, accuracy: 0.001)
        XCTAssertEqual(image!.size.height, size.height, accuracy: 0.001)
    }
    
    func testPerformanceImageIO() {
        var image: UIImage?
        self.measure {
            image = ImageIO.resizedImage(at: url, for: size)
        }
        
        XCTAssertNotNil(image)
        XCTAssertEqual(image!.size.width, size.width, accuracy: 0.001)
        XCTAssertEqual(image!.size.height, size.height, accuracy: 0.001)
    }
    
    func testPerformanceImageIOWithHintingAndSubsampling() {
        var image: UIImage?
        self.measure {
            image = ImageIO.resizedImageWithHintingAndSubsampling(at: url, for: size)
        }
        
        XCTAssertNotNil(image)
        XCTAssertEqual(image!.size.width, size.width, accuracy: 0.001)
        XCTAssertEqual(image!.size.height, size.height, accuracy: 0.001)
    }
    
    func testPerformanceUIKit() {
        var image: UIImage?
        
        self.measure {
            image = UIKit.resizedImage(at: url, for: size)
        }
        
        XCTAssertNotNil(image)
        XCTAssertEqual(image!.size.width, size.width, accuracy: 0.001)
        XCTAssertEqual(image!.size.height, size.height, accuracy: 0.001)
    }
    
    func testPerformanceVImage() {
        var image: UIImage?

        self.measure {
            image = vImage.resizedImage(at: url, for: size)
        }
        
        XCTAssertNotNil(image)
        XCTAssertEqual(image!.size.width, size.width, accuracy: 0.001)
        XCTAssertEqual(image!.size.height, size.height, accuracy: 0.001)
    }
}
