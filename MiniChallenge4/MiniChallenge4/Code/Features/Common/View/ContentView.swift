//
//  ContentView.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 30/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var senacMapViewModel = SenacMapViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onReceive(senacMapViewModel.$senacMap, perform: { _ in
            print("\(senacMapViewModel.senacMap)")
        })
        .padding()
    }
}

#Preview {
    ContentView()
}
