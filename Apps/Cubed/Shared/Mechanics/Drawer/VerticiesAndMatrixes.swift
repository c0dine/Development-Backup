//
//  ShapeRenderer.swift
//  iOS
//
//  Created by The Three Monkeys on 2020-10-16.
//

import Foundation
import SwiftUI

enum ConversionError: Error {
    case InvalidArrayGiven
}
// Oh jeez this is going to be a big file
protocol Verticies: Identifiable, Hashable{
    var coordinateMatrix: Array<Array<CGFloat>> { get }
    var shadowMatrix: Array<Array<CGFloat>> { get }
}
protocol V2D {
    var x: CGFloat { get set }
    var y: CGFloat { get set }
}
protocol V3D {
    var x: CGFloat { get set }
    var y: CGFloat { get set }
    var z: CGFloat { get set }
}
protocol V4D {
    var x: CGFloat { get set }
    var y: CGFloat { get set }
    var z: CGFloat { get set }
    var w: CGFloat { get set }
}
protocol V5D {
    var x: CGFloat { get set }
    var y: CGFloat { get set }
    var z: CGFloat { get set }
    var w: CGFloat { get set }
    var h: CGFloat { get set }
}
struct Verticies2D: Verticies, V2D {  
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var coordinateMatrix: Array<Array<CGFloat>> {
        return [
            [x],
            [y]
        ]
    }
    var shadowMatrix = [
        [CGFloat(1.0),CGFloat(0.0)]
    ]
}
struct Verticies3D: Verticies, V3D {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
    var coordinateMatrix: Array<Array<CGFloat>> {
        return [
            [x],
            [y],
            [z]
        ]
    }
    var shadowMatrix = [
        [CGFloat(1.0), CGFloat(0.0), CGFloat(0.0)],
        [CGFloat(0.0), CGFloat(1.0), CGFloat(0.0)]
    ]
}
struct Verticies4D: Verticies, V4D {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
    var w: CGFloat
    var coordinateMatrix: Array<Array<CGFloat>> {
        return [
            [x],
            [y],
            [z],
            [w]
        ]
    }
    var shadowMatrix = [
        [CGFloat(1.0),CGFloat(0.0),CGFloat(0.0),CGFloat(0.0)],
        [CGFloat(0.0),CGFloat(1.0),CGFloat(0.0),CGFloat(0.0)],
        [CGFloat(0.0),CGFloat(0.0),CGFloat(1.0),CGFloat(0.0)]
    ]
}
struct Verticies5D: Verticies, V5D {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
    var w: CGFloat
    var h: CGFloat
    var coordinateMatrix: Array<Array<CGFloat>> {
        return [
            [x],
            [y],
            [z],
            [w],
            [h]
        ]
    }
    let shadowMatrix = [
        [CGFloat(1.0),CGFloat(0.0),CGFloat(0.0),CGFloat(0.0),CGFloat(0.0)],
        [CGFloat(0.0),CGFloat(1.0),CGFloat(0.0),CGFloat(0.0),CGFloat(0.0)],
        [CGFloat(0.0),CGFloat(0.0),CGFloat(1.0),CGFloat(0.0),CGFloat(0.0)],
        [CGFloat(0.0),CGFloat(0.0),CGFloat(0.0),CGFloat(1.0),CGFloat(0.0)]
    ]
}

class VerticiesManager: Equatable, ObservableObject {
    let array = [
        Verticies3D(x: -50, y: -50, z: 0),
        Verticies3D(x: 50, y: -50, z: 0),
        Verticies3D(x: 50, y: 50, z: 0),
        Verticies3D(x: -50, y: 50, z: 0)
    ]
    static func ==(lhs: VerticiesManager, rhs: VerticiesManager) -> Bool {
        return lhs.array == rhs.array
    }
}
/*
 * Inception is the bare necessity when you need to ladder call
 */
func verticiesToCGPoint(verticies: Verticies2D) -> CGPoint {
    return CGPoint(x: verticies.x, y: verticies.y)
}

func verticiesToCGPoint(verticies: Verticies3D) -> CGPoint {
    var final = CGPoint()
    do {
        let point3DArray = try MatrixProjector(projection: verticies.shadowMatrix).cast(points: verticies.coordinateMatrix)
        final = verticiesToCGPoint(verticies: Verticies2D(x: point3DArray[0][0], y: point3DArray[1][0]))
    } catch {
        print("Unexpected error on 3D conversion: \(error)")
    }
    return final
}

func verticiesToCGPoint(verticies: Verticies4D) -> CGPoint {
    var final = CGPoint()
    do {
        let point3DArray = try MatrixProjector(projection: verticies.shadowMatrix).cast(points: verticies.coordinateMatrix)
        final = verticiesToCGPoint(verticies: Verticies3D(x: point3DArray[0][0], y: point3DArray[1][0], z: point3DArray[2][0]))
    } catch {
        print("Unexpected error on 4D conversion: \(error)")
    }
    return final
}

func verticiesToCGPoint(verticies: Verticies5D) -> CGPoint {
    var final = CGPoint()
    do {
        let point4DArray = try MatrixProjector(projection: verticies.shadowMatrix).cast(points: verticies.coordinateMatrix)
        //print("\(point4DArray)")
        final = verticiesToCGPoint(verticies: Verticies4D(x: point4DArray[0][0], y: point4DArray[1][0], z: point4DArray[2][0], w: point4DArray[3][0]))
    } catch {
        print("Unexpected error on 5D conversion: \(error)")
    }
    return final
}

func arrayToVerticies(array: Array<Array<CGFloat>>) -> Any {
    let rows = array.count
    var endResult: Any
    guard rows != 5 else {
        return endResult = Verticies5D(x: array[0][0], y: array[1][0], z: array[2][0], w: array[3][0], h: array[4][0])
    }
    guard rows != 4 else {
        return endResult = Verticies4D(x: array[0][0], y: array[1][0], z: array[2][0], w: array[3][0])
    }
    guard rows != 3 else {
        return endResult = Verticies3D(x: array[0][0], y: array[1][0], z: array[2][0])
    }
    guard rows != 2 else {
        return endResult = Verticies2D(x: array[0][0], y: array[1][0])
    }
    guard rows > 0 else {
        return endResult = "Denied"
    }
    return "Denied"
}

func arrayToVerticies3D(array: Array<Array<CGFloat>>) throws -> Verticies3D {
    let result = arrayToVerticies(array: array)
    guard result as! String != "Denied" else {
        throw ConversionError.InvalidArrayGiven
    }
    return result as! Verticies3D
}

