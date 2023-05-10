import SwiftUI

struct ItemDetailView: View {
    @ObservedObject var viewModel: ItemDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section {
                ZStack(alignment: .bottomTrailing) {
                    Image(uiImage: UIImage(data: viewModel.place.imageData ?? Data()) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(8)
                    Button(action: viewModel.selectImage) {
                        Image(systemName: "camera.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                    .sheet(isPresented: $viewModel.isShowingImagePicker) {
                        ImagePicker(imageData: $viewModel.place.imageData, isShowingImagePicker: $viewModel.isShowingImagePicker)
                    }
                }
                TextField("Name", text: $viewModel.place.name.onChange(viewModel.savePlace))
                    .font(.largeTitle)
                TextField("Location", text: $viewModel.place.location.onChange(viewModel.savePlace))
                    .font(.subheadline)
            }
            Section {
                TextEditor(text: $viewModel.place.notes.onChange(viewModel.savePlace))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.deletePlace()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "trash")
                }
            }
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let place = Place(context: Persistence.shared.context)
        place.name = "Test Place"
        place.location = "Test Location"
        place.notes = "Test Notes"
        place.imageData = UIImage(named: "default-image")?.jpegData(compressionQuality: 1.0)
        return ItemDetailView(viewModel: ItemDetailViewModel(place: place))
    }
}
