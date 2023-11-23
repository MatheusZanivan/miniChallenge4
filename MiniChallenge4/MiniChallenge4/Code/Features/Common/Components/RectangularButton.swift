//
//  RectangularButton.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 07/11/23.
//

import SwiftUI

struct RectangularButton: View {
    private var action: () -> Void
    @Binding var title: String
    
    init(action: @escaping () -> Void, title: Binding<String>) {
        self.action = action
        self._title = title
    }
    
    var body: some View {
        Button(action: {action()}, label: {
            Text(title)
                .frame(minWidth: 200, idealWidth: 300, maxWidth: 300, alignment:.leading)
                .padding([.vertical], 8)
                .padding(.horizontal)
                .background(Color(red: 0.75, green: 0.75, blue: 0.75))
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 0)), style: FillStyle())
                .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47))

        })
    }
}
