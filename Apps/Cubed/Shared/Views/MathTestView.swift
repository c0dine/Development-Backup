//
//  MathTestView.swift
//  iOS
//
//  Created by The Three Monkeys on 2020-10-17.
//

import SwiftUI

struct MathTestView: View {
    @EnvironmentObject var settings: EnvironmentClass
    var body: some View {
        VStack(spacing: 20) {
            Button("Test mAtRiX") {
                UserDefaults.standard.set(settings.testsMade + 1, forKey: "testCount")
                settings.testsMade = settings.testsMade + 1
                let projector = MatrixProjector(projection: [
                    [1,0,0],
                    [0,1,0]
                ])
                do {
                    try projector.cast(points: [
                            [100],
                            [75],
                            [0]
                    ])
                } catch {
                    print("------------------Ending------------------")
                    print("Unexpected error: \(error)")
                }
            }
            
            Button("Test Settings Verticies") {
                UserDefaults.standard.set(settings.testsMade + 1, forKey: "testCount")
                settings.testsMade = settings.testsMade + 1
                print("---------------Printing-Values--------------")
                var repeatCount = 1
                for vert in settings.verticies.array {
                    print("Verticies #\(repeatCount)")
                    print("----------------")
                    print("Verticies x: \(vert.x)")
                    print("Verticies y: \(vert.y)")
                    print("Verticies shadowMatrix: \(vert.shadowMatrix)")
                    print("Verticies coordinate matrix: \(vert.coordinateMatrix)")
                    print("")
                }
            }
            
            Button("Test Inception Matrix Conversion Function (Level 5)") {
                UserDefaults.standard.set(settings.testsMade + 1, forKey: "testCount")
                settings.testsMade = settings.testsMade + 1
                print("Starting Values:")
                print("x: 50")
                print("y: 20")
                print("z: 34")
                print("w: 88")
                print("h: 69")
                print("----------------")
                let conversionVariable = Verticies5D(x: 50,y: 20,z: 34,w: 88,h: 69)
                let finalPoint = verticiesToCGPoint(verticies: conversionVariable)
                print("////////////////////////////////")
                print("Final CGPoint: \(finalPoint)")
                print("////////////////////////////////")
            }
        }
    }
}

struct MathTestView_Previews: PreviewProvider {
    static var previews: some View {
        MathTestView()
    }
}
