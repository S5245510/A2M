import SwiftUI
import CoreData
import Foundation

struct PlaceList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Place.name, ascending: true)],
        animation: .default)
    private var places: FetchedResults<Place>

    var body: some View {
        NavigationView {
            List {
                ForEach(places) { place in
                    NavigationLink(destination: PlaceDetailView(place: place)) {
                        HStack {
                            Image(uiImage: UIImage(data: place.imageData ?? Data()) ?? UIImage())
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                            VStack(alignment: .leading) {
                                Text(place.name ?? "")
                                Text(place.location ?? "")
                            }
                        }
                    }
                }
                .onDelete(perform: deletePlaces)
                .onMove(perform: movePlaces)
            }
            .navigationBarItems(trailing: EditButton())
        }
    }

    private func deletePlaces(offsets: IndexSet) {
        withAnimation {
            offsets.map { places[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                // Handle the error
            }
        }
    }

    private func movePlaces(from source: IndexSet, to destination: Int) {
        // Implement the reordering functionality
    }
}
