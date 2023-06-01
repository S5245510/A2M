import XCTest
import CoreData
@testable import A2M

final class PlaceDataTests: XCTestCase {

    // MARK: - Test Attributes
    
    let testName = "Test Place"
    let testLocation = "Test Location"
    let testNotes = "Test Notes"
    let testLatitude: Double = 23
    let testLongitude: Double = -23
    let testImageData = "Test Image Data"

    // MARK: - Test Case
    
    func testPlaceAttributes() throws {
        // Setup
        let context = PersistentStorageController.shared.context
        let place = Place(context: context)
        
        // Test
        place.name = testName
        place.location = testLocation
        place.notes = testNotes
        place.latitude = testLatitude
        place.longitude = testLongitude
        place.imageData = testImageData
        
        // Assert
        XCTAssertEqual(place.name, testName)
        XCTAssertEqual(place.location, testLocation)
        XCTAssertEqual(place.notes, testNotes)
        XCTAssertEqual(place.latitude, testLatitude)
        XCTAssertEqual(place.longitude, testLongitude)
        XCTAssertEqual(place.imageData, testImageData)
    }

}
