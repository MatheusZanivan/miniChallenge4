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
            SelectedPlaceView(place: option.nome)
        } label: {
            VStack {
                Text(option.nome)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical,12)
                    .foregroundStyle(Color(.gsFontBody))
                Divider()
                    .frame(minHeight: 1)
                    .padding(.horizontal, 24)
                    .overlay {
                        Color(.gsFontBody)
                            .padding(.horizontal, 24)
                    }
            }
        }
    }
}
