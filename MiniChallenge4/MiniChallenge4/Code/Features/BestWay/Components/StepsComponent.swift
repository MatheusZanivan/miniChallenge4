//
//  StepsComponent.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 02/11/23.
//

import SwiftUI

struct StepsComponent: View {
    @Binding var steps: [String]
    @State var indexStep = 0
    @State var opacityPrevious: Double = 0.5
    @State var opacityNext: Double = 1
    var body: some View {
        VStack {
            if !steps.isEmpty {
                Text("\(steps[indexStep])")
                    .font(.system(size: 25))
                    .padding(.bottom)
            }
            HStack {
                Button {
                    if indexStep > 0 {
                        indexStep -= 1
                    }
                } label: {
                    Text("Previous")
                        .opacity(opacityPrevious)
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.width / 3)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        
                }

                Button {
                    if indexStep < (steps.count - 1) {
                        indexStep += 1
                    }
                } label: {
                    Text("Next")
                        .opacity(opacityNext)
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.width / 3)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                }
            }
        }
        .onAppear() {
            setupOpacityButtons()
        }
        .onChange2(of: steps, action17: { _, _ in
            indexStep = 0
            setupOpacityButtons()
        }, actionLower: { _ in
            indexStep = 0
            setupOpacityButtons()
        })
        
        .onChange2(of: indexStep, action17: { oldValue, newValue in
            setupOpacityButtons()
        }, actionLower: { newValue in
            setupOpacityButtons()
        })
    }
    
    
    func setupOpacityButtons() {
        switch indexStep {
        case 0:
            if (steps.count - 1) == 0 {
                opacityNext = 0.5
                opacityPrevious = 0.5
            } else {
                opacityPrevious = 0.5
                opacityNext = 1
            }
        case (steps.count - 1):
            opacityNext = 0.5
            opacityPrevious = 1
        default:
            opacityNext = 1
            opacityPrevious = 1
        }
    }
}
