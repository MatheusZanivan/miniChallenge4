//
//  RectangularButton.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 07/11/23.
//

import SwiftUI

struct RectangularButton: View {
    private var action: () -> Void
    @Binding private var color: String
    private var border: Bool
    private var borderColor: Color
    private var maxWidth: CGFloat
    private var alignmentCenter: Bool
    @Binding var title: String
    
    
    init(action: @escaping () -> Void, title: Binding<String>, color: Binding<String>, edgesActive: Bool = false, borderColor: Color = .white, maxWidth: CGFloat = 300, aligmentCenter: Bool = false) {
        self.action = action
        self._title = title
        self._color = color
        self.border = edgesActive
        self.borderColor = borderColor
        self.maxWidth = maxWidth
        self.alignmentCenter = aligmentCenter
    }
    
    var body: some View {
        Button(action: {action()}, label: {
            Text(title)
                .frame(minWidth: maxWidth, idealWidth: maxWidth, maxWidth: maxWidth, alignment: alignmentCenter ? .center : .leading)
                .padding([.vertical], 8)
                .padding(.horizontal)
                .background(color == title ? Color("GSColor-\(color)") : .white)
                .foregroundStyle(color == title ? .white : .gray)
                .modifier(BorderButton(edgesActive: border, color: borderColor))
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 0)), style: FillStyle())
        })
    }
}

struct BorderButton: ViewModifier {
    
    private var edgesActive: Bool
    private var color: Color
    
    init(edgesActive: Bool, color: Color) {
        self.edgesActive = edgesActive
        self.color = color
    }
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if edgesActive {
            content
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(color, lineWidth: 1)

                }
        }else{
            content
        }
    }
    
    
}
