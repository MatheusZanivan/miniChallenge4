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
			CameraViewControlerRepresentable()
				.ignoresSafeArea()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
