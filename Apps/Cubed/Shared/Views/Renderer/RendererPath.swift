//
//  RendererPath.swift
//  Cubed
//
//  Created by The Three Monkeys on 2020-10-19.
//

import SwiftUI

struct RendererPath: Shape {
    @State var settings: EnvironmentClass
    @State var array: Array<Verticies3D>
    func path(in rect: CGRect) -> Path {
        var path = Path { path in
            for item in array {
                let width: CGFloat = min(rect.width,rect.height) / 2
                let height = width
                let pointX = CGFloat(width + CGFloat(item.x))
                let pointY = CGFloat(height + CGFloat(item.y))
                path.move(
                    to: CGPoint(
                            x: pointX,
                            y: pointY
                    )
                )
                path.addLine(
                    to: CGPoint(
                            x: pointX,
                            y: pointY
                    )
                )
            }
        }
        path = path.strokedPath(StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round)).animation(.easeOut) as! Path
        return path
    }
}
/*
struct RendererPath_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangle(cornerRadius: 25, style: .continuous).fill(Color.blue).mask(RendererPath(settings: EnvironmentClass()))
    }
}
 */
