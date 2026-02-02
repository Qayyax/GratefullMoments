//
//  ContentView.swift
//  GratefulMoments
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
          Text("This is lagging")
          Text("I don't think it is lagging anymore")
            .fontWeight(.bold)
          // I would continue with the tutorial from my ipad`
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
