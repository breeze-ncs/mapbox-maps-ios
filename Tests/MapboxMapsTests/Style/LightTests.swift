import XCTest
@_spi(Experimental) @testable import MapboxMaps

class LightTests: XCTestCase {

    func testLightEncodingAndDecoding() throws {
        var light = Light()
        light.anchor = .map
        light.color = StyleColor(.red)
        light.intensity = 1.0
        light.intensityTransition = StyleTransition(duration: 10.0, delay: 20.0)
        light.position = [1.0, 2.0, 3.0]
        light.colorTransition = StyleTransition(duration: 10.0, delay: 20.0)

        var data: Data?
        do {
            data = try JSONEncoder().encode(light)
        } catch {
            XCTFail("Failed to encode Light.")
        }

        guard let validData = data else {
            XCTFail("Failed to encode Light.")
            return
        }

        do {
            let decodedLight = try JSONDecoder().decode(Light.self, from: validData)

            XCTAssert(decodedLight.anchor == .map)
            XCTAssert(decodedLight.color == StyleColor(.red))
            XCTAssert(decodedLight.intensity == 1.0)
            XCTAssert(decodedLight.position == [1.0, 2.0, 3.0])
        }
    }

}
