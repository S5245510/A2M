import SwiftUI
import MapKit

struct PlaceDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: PlaceViewModel
    @State private var viewID: Int = 0
    @State private var isLoading = false
    
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
            VStack(alignment: .leading) {
                Text(updatedPlace.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                // to check if there is a URL otherwise show Grey color
                if !isEditMode {
                    VStack(alignment: .leading, spacing: 10) {

                        if let imageDataString = updatedPlace.imageData,
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
                    }// to show Detail from Mapeditor
                    NavigationLink(destination: MapEditorView(model: MyLocation.shared, place: $updatedPlace, viewModel: viewModel, viewID : $viewID)) {
                        VStack(alignment: .leading) {
                            Text("Map of \(updatedPlace.name ?? "")")
                                .fontWeight(.bold)
                            Text("\(updatedPlace.latitude)")
                            Text("\(updatedPlace.longitude)")
                        }
                    }
                } else {// Created a fill in form with placeholder for users
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
                    updateAll()
                }
                isEditMode.toggle() // Toggle the edit mode state
                isLoading = true
            }) {
                Text(isEditMode ? "Done" : "Edit")
            }
        })
        .onAppear {
            updateAll()
        
        }
        // use change of viewID to force reloading when returning from Mapeditor
        .onChange(of: viewID){ newValue in
            updateAll()
        }
        
    }
    
    private func updateAll() {
        editedName = updatedPlace.name ?? ""
        editedLocation = updatedPlace.location ?? ""
        editedNotes = updatedPlace.notes ?? ""
        imageURL = updatedPlace.imageData ?? ""
        // Update latitude and longitude
        updatedPlace.latitude = place.latitude
        updatedPlace.longitude = place.longitude
        updateImage()
        savePlace()
    }
    
    private func savePlace() {
        place.name = editedName
        place.location = editedLocation
        place.notes = editedNotes
        place.imageData = imageURL
        viewModel.savePlace(place: place)

    }
    
    private func updateImage() {
        guard let url = URL(string: imageURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let _ = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.place.imageData = data.base64EncodedString()
                    self.viewModel.savePlace(place: self.place)
                }
            }
        }.resume()
    }


}
