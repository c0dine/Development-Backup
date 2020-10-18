//
//  RingView.swift
//  HyperGan
//
//  Created by The Three Monkeys on 2020-10-17.
//

import SwiftUI

struct RingView: View {
    @State private var show = false
    let defaultTrim = CGFloat(0.0)
    var width: CGFloat
    var height: CGFloat
    @State var progress: CGFloat?
    var color: Color?
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.clear)
                .frame(width: width, height: height, alignment: .center)
                .onTapGesture {
                    show.toggle()
                }
            Circle()
                .trim(from: show ? progress != nil ? progress! : defaultTrim : defaultTrim, to:1)
                .stroke(Color.green, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(90))
                .rotation3DEffect(
                    .degrees(180),
                    axis: (x: 1, y: 0, z: 0)
                )
                .frame(width: width, height: height, alignment: .center)
                .animation(.easeOut(duration: 3))
                .onAppear {
                    show.toggle()
                }
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(width: 50, height: 50, progress: 0.25, color: .green).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
