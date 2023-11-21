//
//  MiniChallenge4App.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 30/10/23.
//

import SwiftUI

@main
struct MiniChallenge4App: App {
    @StateObject var senacMapViewModel = SenacMapViewModel()
    var body: some Scene {
        WindowGroup {
             ChoosingDestinyView()
                 .environmentObject(senacMapViewModel)
        }
    }
}
