

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var name: String?
    @NSManaged public var location: String?
    @NSManaged public var notes: String?
    @NSManaged public var imageData: Data?

}

extension Place : Identifiable {

}
