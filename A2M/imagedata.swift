import SwiftUI
import Foundation

extension Place {
    var rowDisplay: String {
        "Name: \(self.name ?? "") (Location: \(self.location ?? ""))"
    }
    
    func getImage(for place: Place) async -> Image {
        guard let urlString = place.imageData, let url = URL(string: urlString) else {
            return Image(systemName: "photo").resizable()
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let uiImage = UIImage(data: data) else {
                return Image(systemName: "photo").resizable()
            }
            
            return Image(uiImage: uiImage).resizable()
        } catch {
            print("Error in downloading image: \(error)")
            return Image(systemName: "photo").resizable()
        }
    }

}
