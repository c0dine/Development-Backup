//
//  Environment.swift
//  iOS
//
//  Created by The Three Monkeys on 2020-10-17.
//

import Foundation
import SwiftUI
import Combine

class EnvironmentClass: ObservableObject {
    @Published var testsMade = UserDefaults.standard.integer(forKey: "testCount")
    @Published var verticies = VerticiesManager()
    @Published var animating = false
    @Published var refreshTime = 0.2
    @Published var array = [
        Verticies3D(x: -50, y: -50, z: 0),
        Verticies3D(x: 50, y: -50, z: 0),
        Verticies3D(x: 50, y: 50, z: 0),
        Verticies3D(x: -50, y: 50, z: 0)
    ]
    var angle = 1.0
    var timer: Cancellable? = nil
    func animateVerticies() {
        timer = Timer
            .publish(every: refreshTime, on: RunLoop.main, in: RunLoop.Mode.default)
            .autoconnect()
            .sink(receiveValue: { (_) in
                self.animating = true
                for i in 0...self.array.count-1 {
                    /*
                     Lets start simple with some 2d x rotation?
                     */
                    var array = self.array
                    let rotationMatrixX: Array<Array<CGFloat>> = [
                        [CGFloat(cos(self.angle)), CGFloat(-sin(self.angle)), CGFloat(0.0)],
                        [CGFloat(sin(self.angle)), CGFloat(cos(self.angle)), CGFloat(0.0)],
                        [CGFloat(0.0), CGFloat(0.0), CGFloat(1.0)]
                    ]
                    do {
                        print("rotationMAtrixX: \(rotationMatrixX)")
                        print("\(self.angle)")
                        let assignmentArray = try MatrixProjector(projection: rotationMatrixX).cast(points: array[i].coordinateMatrix)
                        array[i] = Verticies3D(x: assignmentArray[0][0], y: assignmentArray[1][0], z: assignmentArray[2][0])
                        print("Array: \(array[i])")
                    } catch {
                        print("Unexpected error: \(error)")
                    }
                }
                self.angle += 0.2
            })
    }
}
