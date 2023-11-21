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
//            BestWayView(startingNode: .constant("i347"), arrivalNode: .constant("j475"))

//            ChoosingDestinyView()
            ContentView()
// <<<<<<< screen_to_add_route
//             ChoosingDestinyView()
//                 .environmentObject(senacMapViewModel)
// =======
// //            ChoosingDestinyView()
//             ContentView()
// >>>>>>> choosing_destiny_epic
        }
    }
}
