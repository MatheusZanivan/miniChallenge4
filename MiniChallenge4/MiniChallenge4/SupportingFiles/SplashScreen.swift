//
//  SplashScreen.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 06/12/23.
//

import SwiftUI

struct SplashScreen: View {
    @StateObject var senacMapViewModel = SenacMapViewModel()
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.8

    var body: some View {
        if #available(iOS 17.0, *) {
            if isActive{
                InitialPageView()
                    .environmentObject(senacMapViewModel)
            } else {
                ZStack(content: {
                    Color.GSBlue
                        .ignoresSafeArea()
                    VStack{
                        Image("GSLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                    }.scaleEffect(size)
                        .opacity(opacity)
                        .onAppear(perform: {
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        })
                }).onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        withAnimation(.easeInOut(duration: 0.8)) {
                            self.opacity = 0.0
                            self.size = 0.0
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.69){
                                withAnimation(.easeInOut) {
                                    self.isActive = true
                                }
                                
                            }
                        }
                        
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
