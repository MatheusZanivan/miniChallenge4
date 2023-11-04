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
                    Divider()
                        .padding(.horizontal, 48)
                }
            }
        }.frame(height: 240)
    }
}
