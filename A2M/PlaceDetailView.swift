import SwiftUI

struct PlaceDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: PlaceViewModel
    let place: Place
    @State private var isEditMode = false
    @State private var editedName: String = ""
    @State private var editedLocation: String = ""
    @State private var editedNotes: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10) {
                Text(place.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                if !isEditMode {
                    VStack(alignment: .leading, spacing: 10) {
                    
                        Text(place.location ?? "")
                            .padding(.bottom)
                        Text("Description")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom)
                        Text(place.notes ?? "")
                            .padding(.bottom)
                    }
                    NavigationLink(destination: MapEditorView( place: place)) {
                        VStack {
                            Text("Map of \(place.name ?? "")")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("\(place.latitude)")
                            Text("\(place.longitude)")
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
            editedName = place.name ?? ""
            editedLocation = place.location ?? ""
            editedNotes = place.notes ?? ""
        }
    }
    
    private func savePlace() {
        place.name = editedName
        place.location = editedLocation
        place.notes = editedNotes
        viewModel.savePlace(place: place)
    }
}
