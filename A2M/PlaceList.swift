import SwiftUI
import CoreData
import Foundation

struct PlaceList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var viewModel = PlaceViewModel()

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Place.name, ascending: true)],
        animation: .default)
    private var places: FetchedResults<Place>

    var body: some View {
        NavigationView {
            List {
                ForEach(places) { place in
                    NavigationLink(destination: PlaceDetailView(place: place, viewModel: viewModel)) {
                        HStack {
                            Image(uiImage: UIImage(data: place.imageData ?? Data()) ?? UIImage())
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                            VStack(alignment: .leading) {
                                Text(place.name ?? "")
                            }
                        }
                    }
                }
                .onDelete(perform: deletePlaces)
                .onMove(perform: movePlaces)
            }
            .navigationBarItems(
                leading: EditButton(),
                trailing: HStack {
                    Button(action: {
                        viewModel.addPlace(name: "New Place", location: "New Location", notes: "New Notes", latitude: 0.0, longitude: 0.0, imageData: Data())
                    }) {
                        Image(systemName: "plus")
                    }
                }
            )

        }
    }

    private func deletePlaces(offsets: IndexSet) {
        withAnimation {
            offsets.map { places[$0] }.forEach { place in
                viewModel.deletePlace(place: place)
            }
        }
    }

    private func movePlaces(from source: IndexSet, to destination: Int) {
        // Implement the reordering functionality
    }
}
