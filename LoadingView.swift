import SwiftUI
import Foundation

struct LoadingView: View {
    @State private var isLoading = true

    var body: some View {
        VStack {
            // Show loading indicator or other content while loading
            if isLoading {
                ProgressView()
            } else {
                // Redirect to PlaceDetailView when loading is completed
                EmptyView()
                    .onAppear {
                        // Navigate to PlaceDetailView
                        // You can use a navigation link or a presentation mode
                    }
            }
        }
        .onAppear {
            // Simulate loading time
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoading = false
            }
        }
    }
}
