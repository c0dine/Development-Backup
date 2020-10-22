//
//  RenderPageView.swift
//  Cubed
//
//  Created by The Three Monkeys on 2020-10-18.
//

import SwiftUI

struct RenderPageView: View {
    @State var isDragging = false
    @State var viewState = CGSize()
    let gradientArray = [
        Color(red: 0.01, green: 0.99, blue: 0.94),
        Color(red: 0.01, green: 0.50, blue: 0.99)
    ]
    @State var endPoint = UnitPoint(x:0.25, y: 4)
    var body: some View {
        VStack(spacing: 20) {
            Renderer()
                .frame(width: 300, height: 300)
                .background(
                    RoundedRectangle(cornerRadius: 35, style: .continuous)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: gradientArray),
                            startPoint: UnitPoint(x: 0, y: 0),
                            endPoint: endPoint
                        )
                    )
                    .opacity(0.8)
                    .shadow(color: Color(red: 0.01, green: 0.99, blue: 0.94, opacity: 0.2), radius: 8, x: -5, y: -5)
                    .shadow(color: Color(red: 0.01, green: 0.50, blue: 0.99, opacity: 0.2), radius: 8, x: 5, y: 5)
                    .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true))
                    .onAppear {
                        endPoint = UnitPoint(x: 0.25, y: 1.25)
                    }
                )
                .animation(.easeOut)
                .scaleEffect(isDragging ? 0.98 : 1)
                .rotation3DEffect(
                    .degrees(20),
                    axis: (x: viewState.height / -10, y:viewState.width / 10, z: 0)
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            viewState = value.translation
                            isDragging = true
                        }
                        .onEnded { value in
                            viewState = .zero
                            isDragging = false
                        }
                )
        }
    }
}

struct RenderPageView_Previews: PreviewProvider {
    static var previews: some View {
        RenderPageView()
    }
}
