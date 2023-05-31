import SwiftUI
import MapKit

struct PlaceDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: PlaceViewModel
    
    
    let place: Place
    @State private var isEditMode = false
    @State private var editedName: String = ""
    @State private var editedLocation: String = ""
    @State private var editedNotes: String = ""
    @State private var imageURL: String = ""
    @State private var viewLoaded = false
    @State private var updatedPlace: Place
    
    init(place: Place, viewModel: PlaceViewModel) {
        self.place = place
        self.viewModel = viewModel
        self._updatedPlace = State(initialValue: place)
        self._imageURL = State(initialValue: place.imageData ?? "")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10) {
                Text(updatedPlace.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if !isEditMode {
                    VStack(alignment: .leading, spacing: 10) {

                        if let imageDataString = place.imageData,
                           let imageData = Data(base64Encoded: imageDataString),
                           let image = UIImage(data: imageData) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                        } else {
                            Color.gray
                        }
                        Text("Description")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom)
                        Text(updatedPlace.notes ?? "")
                            .padding(.bottom)
                    }
                    NavigationLink(destination: MapEditorView(model: MyLocation.shared, place: $updatedPlace, viewModel: viewModel)) {
                        VStack {
                            Text("Map of \(updatedPlace.name ?? "")")
                                .fontWeight(.bold)
                            Text("\(place.latitude)")
                            Text("\(place.longitude)")
                        }
                    }
                } else {
                    VStack(alignment: .leading, spacing: 10) {
                        LabelTextField(label: "Name", placeHolder: "Fill in the location", text: $editedName)
                        LabelTextField(label: "Image", placeHolder: "Fill in the URL", text: $imageURL)
                        LabelTextField(label: "Notes", placeHolder: "Fill in the description", text: $editedNotes)
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationBarItems(trailing: HStack {
            Button(action: {
                if isEditMode {
                    savePlace()
                }
                isEditMode.toggle() // Toggle the edit mode state
            }) {
                Text(isEditMode ? "Done" : "Edit")
            }
        })
        .onAppear {
            editedName = updatedPlace.name ?? ""
            editedLocation = updatedPlace.location ?? ""
            editedNotes = updatedPlace.notes ?? ""
            imageURL = updatedPlace.imageData ?? ""
            // Update latitude and longitude
            updatedPlace.latitude = place.latitude
            updatedPlace.longitude = place.longitude
            shouldRefresh = false
        }
        
    }
    
    private func savePlace() {
        updatedPlace.name = editedName
        updatedPlace.location = editedLocation
        updatedPlace.notes = editedNotes
        viewModel.savePlace(place: updatedPlace)
    }
    
    private func updateImage() {
        if let url = URL(string: imageURL),
           let imageData = try? Data(contentsOf: url) {
            let base64String = imageData.base64EncodedString()
            updatedPlace.imageData = base64String
            viewModel.savePlace(place: updatedPlace)
        }
    }
}
