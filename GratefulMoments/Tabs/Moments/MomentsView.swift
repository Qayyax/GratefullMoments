import SwiftData
import SwiftUI

struct MomentsView: View {
    @State private var showCreateMoment = false
    @Query(sort: \Moment.timestamp)
    private var moments: [Moment]

    var body: some View {
        NavigationStack {
            ScrollView {
                pathItems
                    .frame(maxWidth: .infinity)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showCreateMoment = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showCreateMoment) {
                        MomentEntryView()
                    }
                }
            }
            .navigationTitle("Grateful Moments")
        }
    }

    private var pathItems: some View {
        ForEach(moments) { moment in
            Text(moment.title)
        }
    }
}

#Preview {
    MomentsView()
        .sampleDataContainer()
}
