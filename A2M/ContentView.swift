import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.places) { place in
                    NavigationLink(destination: ItemDetailView(viewModel: ItemDetailViewModel(place: place))) {
                        HStack {
                            Image(uiImage: UIImage(data: place.imageData ?? Data()) ?? UIImage())
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                            VStack(alignment: .leading) {
                                Text(place.name ?? "")
                                    .font(.headline)
                                Text(place.location ?? "")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deletePlace)
            }
            .navigationTitle(viewModel.title)
            .navigationBarItems(
                trailing: Button(action: { viewModel.isAdding = true }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $viewModel.isAdding) {
                AddItemView(isPresented: $viewModel.isAdding, viewModel: AddItemViewModel())
                    .environment(\.managedObjectContext, Persistence.shared.context)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
