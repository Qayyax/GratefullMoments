import PhotosUI
import SwiftData
import SwiftUI
import UIKit

struct MomentEntryView: View {
    @State private var title = ""
    @State private var note = ""
    @State private var imageData: Data?
    @State private var newImage: PhotosPickerItem?
    @State private var isShowingCancelConfirmation = false

    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer

    var body: some View {
        NavigationStack {
            ScrollView {
                contentStack
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Grateful for")
            .toolbar {
                // Cancellation Btn
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        if title.isEmpty, note.isEmpty, imageData == nil {
                            dismiss()
                        } else {
                            isShowingCancelConfirmation = true
                        }
                    }
                    // are you sure you want to discard popup button
                    .confirmationDialog("Discard Moment", isPresented: $isShowingCancelConfirmation) {
                        Button("Discard Moment", role: .destructive) {
                            dismiss()
                        }
                    }
                }

                // Confirmation Btn
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", systemImage: "checkmark") {
                        let newMoment = Moment(
                            title: title,
                            note: note,
                            imageData: imageData,
                            timestamp: .now
                        )
                        dataContainer.context.insert(newMoment)
                        do {
                            try dataContainer.context.save()
                            dismiss()
                        } catch {
                            // Don't dismiss
                        }
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }

    private var photoPicker: some View {
        // This is the part for the photoPicker
        // import PhotoUI
        // Create a stateVariable to store the photoItem
        PhotosPicker(selection: $newImage) {
            Group {
                // we also need to convert the image data after task
                // to an image, thus the if statement
                // Imported uikit to use UIImage
                if let imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "photo.badge.plus.fill")
                        .font(.largeTitle)
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .background(Color(white: 0.4, opacity: 0.32))
                }
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
        .sampleDataContainer()
}
