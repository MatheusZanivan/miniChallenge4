//
//  DropdownMenuList.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 02/11/23.
//

import SwiftUI

struct DropdownMenuList: View {
    let options: [SenacPlaceModel]
    let onSelectionAction: (_ option: SenacPlaceModel) -> Void
    var body: some View {
        ScrollView{
            VStack {
                ForEach(options, id:\.nome) { name in
                    DropdownMenuListRow(
                        option: name,
                        onSelectionAction: self.onSelectionAction
                    )
                }
            }
        }.frame(width: 320, height: 240)
            .background(Color(uiColor: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)))
            .padding(.top, 70)
    }
}
