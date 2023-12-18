//
//  DropdownMenuList.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 02/11/23.
//

import SwiftUI
import SceneKit

struct DropdownMenuList: View {
    let options: [SenacPlaceModel]
    let onSelectionAction: (_ option: SenacPlaceModel) -> Void
    var body: some View {
        ScrollView{
            VStack {
                ForEach(options, id:\.nome) { senacPlace in
//                    if sceneFileExists(filePath: "scenes.scnassets/\(senacPlace.nome.forSorting.split(separator: " ").joined().lowercased())/scene\(senacPlace.nome.forSorting.split(separator: " ").joined().capitalized).scn") {
                        DropdownMenuListRow(
                            option: senacPlace,
                            onSelectionAction: self.onSelectionAction
                        )
//                    }
                }
            }
        }.frame(width: 320, height: 240)
            .background(Color(uiColor: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)))
            .padding(.top, 70)
    }
}
