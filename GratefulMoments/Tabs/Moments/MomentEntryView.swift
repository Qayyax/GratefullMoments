//
//  MomentEntryView.swift
//  GratefulMoments
//
//  Created by Abdul-Qayyum Olatunji on 2026-02-01.
//

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

    var contentStack: some View {
        VStack(alignment: .leading) {
            TextField(text: $title) {
                Text("Title (Required)")
            }
            .font(.title.bold())
            .padding(.top, 48)

            Divider()

            TextField("Log your small wins", text: $note)
                .multilineTextAlignment(.leading)
                .lineLimit(5 ... Int.max)
        }
        .padding()
    }
}

#Preview {
    MomentEntryView()
}
