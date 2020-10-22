//
//  Renderer.swift
//  Cubed
//
//  Created by The Three Monkeys on 2020-10-18.
//

import Foundation
import SwiftUI
import Combine

struct Renderer: View {
    @ObservedObject var settings = EnvironmentClass()
    var body: some View {
        Group() {
            Group() {
                GeometryReader() { geo in
                    ForEach(0...settings.verticies.array.count-1, id: \.self) { index in
                        Path { path in
                            let item = settings.array[index]
                            let width: CGFloat = min(geo.size.width, geo.size.height) / 2
                            let height = width
                               path.move(
                                to: CGPoint(
                                        x: width,
                                        y: width
                                )
                            )
                            path.addLine(
                                to: CGPoint(
                                        x: width,
                                        y: width
                                )
                            )
                        }
                        .stroke(Color.secondary, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .position(
                            x:CGFloat(
                                min(geo.size.width, geo.size.height) / 2
                            ) + settings.array[index].x,
                            y:CGFloat(
                                min(geo.size.width, geo.size.height) / 2
                            ) + settings.array[index].y
                        )
                    }
                }
            }
        }.frame(width: 400, height: 400, alignment: .center)
        .onAppear {
            settings.animateVerticies()
        }
    }
}


struct Renderer_Previews: PreviewProvider {
    static var previews: some View {
        Renderer()
    }
}
