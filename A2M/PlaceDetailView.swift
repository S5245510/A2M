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
        VStack(spacing: 20) {
            VStack {
                Text("MAP OF New Place")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                // Add your MapView here
            }

            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("New Place")
                        .font(.title)
                        .fontWeight(.bold)
                    if isEditMode {
                        TextField("Name", text: $editedName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom, 10)
                    } else {
                        Text(place.name ?? "")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }

                    // Add your image view here

                    if isEditMode {
                        TextField("Location", text: $editedLocation)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom, 10)
                    } else {
                        Text(place.location ?? "")
                    }

                    if isEditMode {
                        TextField("Notes", text: $editedNotes)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom, 10)
                    } else {
                        Text(place.notes ?? "")
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.bottom, 20)

                if !isEditMode {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("CORODINATE")
                            .fontWeight(.bold)
                        // Add your coordinate view here
                    }
                    .padding()
                }
            }

            if isEditMode {
                // Add your coordinate view here
            }

            Button(isEditMode ? "Save" : "Edit") {
                if isEditMode {
                    place.name = editedName
                    place.location = editedLocation
                    place.notes = editedNotes
                    viewModel.savePlace(place: place)
                }
                isEditMode.toggle()
            }
        }
        .navigationBarItems(trailing: Button("Cancel") {
            // Implement cancel button action
        })
        .onAppear {
            editedName = place.name ?? ""
            editedLocation = place.location ?? ""
            editedNotes = place.notes ?? ""
        }
    }
}
