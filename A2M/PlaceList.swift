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
                            if let imageData = Data(base64Encoded: place.imageData ?? "") {
                                if let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                } else {
                                    // Handle the case where the base64 data is invalid and cannot be converted to UIImage
                                    // Display a placeholder image or handle the error as needed
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                }
                            } else {

                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipped()
                            }
                            VStack(alignment: .leading) {
                                Text(place.name ?? "")
                            }
                        }

                    }
                }
                .onDelete(perform: deletePlaces)
                .onMove(perform: movePlaces)
            }
            .task {
                if places.isEmpty {
                    viewModel.loadDefaultData()
                }
            }
            .navigationBarTitle("My Favourite Places")
            .navigationBarItems(
                leading: EditButton(),
                trailing: HStack {
                    Button(action: {
                        viewModel.addPlace(name: "New Place", location: "New Location", notes: "New Notes", latitude: 0.0, longitude: 0.0, imageData: "")
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
