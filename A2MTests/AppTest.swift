import XCTest
import CoreData
@testable import A2M

class A2MTests: XCTestCase {
    
    var persistentStorageController: PersistentStorageController!
    var viewModel: PlaceViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        persistentStorageController = PersistentStorageController()
        viewModel = PlaceViewModel()
    }
    
    override func tearDownWithError() throws {
        persistentStorageController = nil
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testSavePlace() throws {
        // Create a sample place
        let place = Place(context: persistentStorageController.context)
        place.name = "Test Place"
        place.location = "Test Location"
        place.notes = "Test Notes"
        place.latitude = 37.7749
        place.longitude = -122.4194
        place.imageData = "Test Image Data"

        // Save the place using the view model
        viewModel.savePlace(place: place)

        // Fetch the saved places
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        let places = try persistentStorageController.context.fetch(fetchRequest)

        // Assert that at least one place is saved
        XCTAssertGreaterThan(places.count, 0)

        // Find the saved place by name
        let foundPlace = places.first { $0.name == "Test Place" }

        // Assert the attributes of the saved place
        XCTAssertNotNil(foundPlace, "Failed to find the saved place.")
        XCTAssertEqual(foundPlace?.name, "Test Place")
        XCTAssertEqual(foundPlace?.location, "Test Location")
        XCTAssertEqual(foundPlace?.notes, "Test Notes")
        XCTAssertEqual(foundPlace?.latitude, 37.7749)
        XCTAssertEqual(foundPlace?.longitude, -122.4194)
        XCTAssertEqual(foundPlace?.imageData, "Test Image Data")
    }


}
