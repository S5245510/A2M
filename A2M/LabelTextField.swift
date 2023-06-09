import SwiftUI

struct LabelTextField: View {
    var label: String
    var placeHolder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            TextField(placeHolder, text: $text)
                .padding(.all)
                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                .cornerRadius(5.0)
        }
        .padding(.horizontal, 15)
    }
}
