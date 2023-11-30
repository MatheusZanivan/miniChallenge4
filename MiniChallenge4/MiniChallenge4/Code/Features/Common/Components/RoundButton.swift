//
//  RoundButton.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 06/11/23.
//

import SwiftUI

struct RoundButton: View {
    
    private let action: () -> Void
    private let imageButton: Image
    private let frameHeight: CGFloat?
    private let frameWidth: CGFloat?
    private let padding: CGFloat
    private var activeBackgound: Bool
    private var color: Color
    
    init(action: @escaping () -> Void, imageButton: Image, frameHeight: CGFloat = 32, frameWidth: CGFloat = 32, padding: CGFloat = 12, activeBackground: Bool = false, color: Color = .white) {
        self.action = action
        self.imageButton = imageButton
        self.frameHeight = frameHeight
        self.frameWidth = frameWidth
        self.padding = padding
        self.activeBackgound = activeBackground
        self.color = color
    }

    var body: some View {
        Button {
            action()
        } label: {
            imageButton
                .resizable()
                .frame(width: frameHeight, height: frameWidth)
                .padding(padding)
                .modifier(BackgroundButton(activeBackgound, with: color))
                .cornerRadius(40)
        }
    }
}

struct BackgroundButton: ViewModifier {
    private var activeBackground: Bool
    private var backgroundColor: Color
    init(_ activeBackground: Bool = false, with background: Color = .white) {
        self.activeBackground = activeBackground
        self.backgroundColor = background
    }
    @ViewBuilder
    func body(content: Content) -> some View {
        if activeBackground {
            content
                .background(backgroundColor)
        } else {
            content
        }
    }
}
