//
//  NavigationWidget.swift
//  HyperGan
//
//  Created by The Three Monkeys on 2020-10-17.
//

import SwiftUI

public struct NavigationWidget: View {
    @State private var isDragging = false
    @State var viewState = CGSize()
    //@State var testCount = UserDefaults.standard.integer(forKey: "testCount")
    @EnvironmentObject var settings:  EnvironmentClass
    //@State var progressNumber = CGFloat(100 - settings.testsMade) / 100
    let gradientArray = [
        Color(red: 0.01, green: 0.99, blue: 0.94),
        Color(red: 0.01, green: 0.50, blue: 0.99)
    ]
    @State var endPoint = UnitPoint(x:0.25, y: 4)
    
    let gradient = LinearGradient(gradient: Gradient(colors: [
        Color(red: 0.01, green: 0.99, blue: 0.94),
        Color(red: 0.01, green: 0.50, blue: 0.99)
    ]), startPoint: .topLeading, endPoint: .bottomTrailing)
    public var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(LinearGradient(gradient: Gradient(colors: gradientArray), startPoint: UnitPoint(x: 0, y: 0), endPoint: endPoint))
            .frame(width: 175, height: 100, alignment: .center)
            .padding().padding(.bottom)
            .opacity(0.8)
            .shadow(color: Color(red: 0.01, green: 0.99, blue: 0.94, opacity: 0.2), radius: 8, x: -5, y: -5)
            .shadow(color: Color(red: 0.01, green: 0.50, blue: 0.99, opacity: 0.2), radius: 8, x: 5, y: 5)
            .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true))
            .onAppear {
                endPoint = UnitPoint(x: 0.25, y: 1.25)
            }
            .overlay(VStack() {
                Text("Cubed")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                Text("Tests Made / 100")
                Text("\(settings.testsMade)").overlay(
                    RingView(width: 25, height: 25, progress: CGFloat(100 - settings.testsMade) / 100, color: .green)
                ).offset(y: 10)
            }.offset(y: -10))
        }.padding(.top)
        .padding(.leading, 5)
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

struct NavigationWidget_Previews: PreviewProvider {
    static var previews: some View {
        NavigationWidget()
    }
}
