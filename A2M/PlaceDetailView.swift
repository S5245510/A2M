import SwiftUI

struct PlaceDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: PlaceViewModel
    let place: Place
    @State private var isEditMode = false
    @State private var editedName: String = ""
    @State private var editedLocation: String = ""
    @State private var editedNotes: String = ""
    
    @State private var updatedPlace: Place // Add this line
    
    init(place: Place, viewModel: PlaceViewModel) {
        self.place = place
        self.viewModel = viewModel
        self._updatedPlace = State(initialValue: place) // Add this line
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10) {
                Text(updatedPlace.name ?? "") // Update this line
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if !isEditMode {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(updatedPlace.location ?? "") // Update this line
                            .padding(.bottom)
                        Text("Description")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom)
                        Text(updatedPlace.notes ?? "") // Update this line
                            .padding(.bottom)
                    }
                    NavigationLink(destination: MapEditorView(model: MyLocation.shared, place: $updatedPlace, viewModel: viewModel)) { // Update this line
                        VStack {
                            Text("Map of \(updatedPlace.name ?? "")") // Update this line
                                .font(.title)
                                .fontWeight(.bold)
                            Text("\(updatedPlace.latitude)")
                            Text("\(updatedPlace.longitude)")
                        }
                    }
                } else {
                    VStack(alignment: .leading, spacing: 10) {
                        LabelTextField(label: "Name", placeHolder: "Fill in the location", text: $editedName)
                        // Add your image view here
                        LabelTextField(label: "Image", placeHolder: "Fill in the url", text: $editedLocation)
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
                    isEditMode.toggle()
                } else {
                    isEditMode.toggle()
                }
            }) {
                Text(isEditMode ? "Done" : "Edit")
            }
        })
        .onAppear {
            editedName = updatedPlace.name ?? "" // Update this line
            editedLocation = updatedPlace.location ?? ""
            editedNotes = updatedPlace.notes ?? ""
        }
        .onAppear {
                    // Refresh the view and update the properties when it appears again
                    editedName = place.name ?? ""
                    editedLocation = place.location ?? ""
                    editedNotes = place.notes ?? ""
                }
    }
    
    private func savePlace() {
        updatedPlace.name = editedName // Update this line
        updatedPlace.location = editedLocation // Update this line
        updatedPlace.notes = editedNotes // Update this line
        viewModel.savePlace(place: updatedPlace) // Update this line
    }
}
