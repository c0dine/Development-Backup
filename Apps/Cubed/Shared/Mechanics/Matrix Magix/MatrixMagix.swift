//
//  MatrixMagix.swift.swift
//  iOS
//
//  Created by The Three Monkeys on 2020-10-16.
//

import Foundation
import SwiftUI
/*
 3D projection to 2D
 Uses this: {{0,1,0},{0,0,1},{0,0,0}}
 to turn this: {{100},{75},{0}}
 into this: {{100},{75}}
 
 guard a.collumns == b.rows else {
    // Matrix multiplication is invalid
 }
 */

enum MatrixError: Error {
    case CollumnsAndRowsUnequal(collumns: Int,rows: Int)
    case IndexOutOfRange(index: Int,range: Int)
}


protocol matrixOperator {
    var projection: Array<Array<CGFloat>> { get set }
    func cast(points: Array<Array<CGFloat>>) throws -> Array<Array<CGFloat>>
}

struct MatrixProjector: matrixOperator {
    var projection: Array<Array<CGFloat>>
    func cast(points: Array<Array<CGFloat>>) throws -> Array<Array<CGFloat>> {
        //print("-----------------Starting-Cast------------------")
        //logMatrix(m: projection)
        //logMatrix(m: points)
        // Variables
        let collumns = points[0].count
        let rows = points.count
        let projectionCollums = projection[0].count
        let projectionRows = projection.count
        //Dont ever skip protection. IT ISN'T SAFE
        guard rows == projectionCollums else {
            throw MatrixError.CollumnsAndRowsUnequal(collumns: collumns, rows: projectionRows)
        }
        var result = Array<Array<CGFloat>>()
        //print("-----------------Starting-Math------------------")
        for i in 0...(projectionRows-1) {
            for j in 0...(collumns-1) {
                var sum: CGFloat = 0
                for k in 0...(rows-1) {
                    sum += projection[i][k] * points[k][j]
                }
                result.append([sum])
            }
        }
        return result
    }
}
func logMatrix(m: Array<Array<CGFloat>>) {
    let collumns = m[0].count
    let rows = m.count
    print("\(collumns)x\(rows)")
    print("--------------------")
    for i in 0...(rows-1) {
        for j in 0...(collumns-1) {
            if j != (collumns-1) {
                print("\(m[i][j])",terminator:",")
            } else {
                print("\(m[i][j])")
            }
        }
        if i == (rows-1){
            print("")
        }
    }
}

/*
func convertTo2D<T: Verticies>(verticies: T) -> T {
    if verticies.x {
        
    }
}
*/
/*
 4D projection to 3D
 
 */
