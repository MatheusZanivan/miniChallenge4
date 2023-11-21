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

    init(action: @escaping () -> Void, imageButton: Image, frameHeight: CGFloat = 32, frameWidth: CGFloat = 32) {
        self.action = action
        self.imageButton = imageButton
        self.frameHeight = frameHeight
        self.frameWidth = frameWidth
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            imageButton
                .resizable()
                .frame(width: frameHeight, height: frameWidth)
                .padding()
                .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                .cornerRadius(40)
                .foregroundStyle(.gray)
        }
        

    }
}
