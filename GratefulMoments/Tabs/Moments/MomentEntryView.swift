import PhotosUI
import SwiftUI

struct MomentEntryView: View {
    @State private var title = ""
    @State private var note = ""
    @State private var imageData: Data?
    @State private var newImage: PhotosPickerItem?

    var body: some View {
        NavigationStack {
            ScrollView {
                contentStack
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Grateful for")
        }
    }

    private var photoPicker: some View {
        // This is the part for the photoPicker
        // import PhotoUI
        // Create a stateVariable to store the photoItem
        PhotosPicker(selection: $newImage) {
            Group {
                Image(systemName: "photo.badge.plus.fill")
                    .font(.largeTitle)
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .background(Color(white: 0.4, opacity: 0.32))
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .onChange(of: newImage) {
            // since it is an optional variable
            guard let newImage else { return }
            // this is asynchronous, Task that is
            Task {
                // LoadTrasfer would transfer the image from gallery to the app
                // as a data type,
                // so create an optional State
                imageData = try await newImage.loadTransferable(type: Data.self)
            }
        }
    }

    var contentStack: some View {
        VStack(alignment: .leading) {
            TextField(text: $title) {
                Text("Title (Required)")
            }
            .font(.title.bold())
            .padding(.top, 48)

            Divider()

            TextField("Log your small wins", text: $note, axis: .vertical)
                .multilineTextAlignment(.leading)
                .lineLimit(5 ... Int.max)

            photoPicker
        }
        .padding()
    }
}

#Preview {
    MomentEntryView()
}
