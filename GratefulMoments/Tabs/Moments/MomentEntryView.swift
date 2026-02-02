import PhotosUI
import SwiftUI

struct MomentEntryView: View {
    @State private var title = ""
    @State private var note = ""
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
        Image(systemName: "photo.badge.plus.fill")
            .font(.largeTitle)
            .frame(height: 250)
            .frame(maxWidth: .infinity)
            .background(Color(white: 0.4, opacity: 0.32))
            .clipShape(RoundedRectangle(cornerRadius: 16))
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
