//
//  SplashView.swift
//  QuickyCart
//
//  Created by Manan Gurung on 03/08/25.
//


//
//  SplashView.swift
//  QuickyCart
//
//  Created by Manan Gurung on 03/08/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var scale: CGFloat = 0.7
    @State private var opacity = 0.0

    var body: some View {
        if isActive {
            PackageView()
        } else {
            ZStack {
                //
                Color.brandPrimary
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Image("LaunchLogo") 
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .scaleEffect(scale)
                        .opacity(opacity)
                }
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.scale = 1.0
                        self.opacity = 1.0
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
