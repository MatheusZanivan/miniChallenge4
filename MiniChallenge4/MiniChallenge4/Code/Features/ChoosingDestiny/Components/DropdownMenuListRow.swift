//
//  DropdownMenuListRow.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 02/11/23.
//

import SwiftUI

struct DropdownMenuListRow: View {
    let option: SenacPlaceModel
    let onSelectionAction: (_ option: SenacPlaceModel) -> Void
    var body: some View {
        NavigationLink {
            LocationDetailsView(place: option.nome)
        } label: {
            Text(option.nome)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
        }
    }
}
