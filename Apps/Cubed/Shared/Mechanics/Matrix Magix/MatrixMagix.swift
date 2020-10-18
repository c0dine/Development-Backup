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
    var projection: Array<Array<Int>> { get set }
    func cast(points: Array<Array<Int>>) throws -> Array<Array<Int>>
}

struct MatrixProjector: matrixOperator {
    var projection: Array<Array<Int>>
    func cast(points: Array<Array<Int>>) throws -> Array<Array<Int>> {
        print("-----------------Starting-Cast------------------")
        logMatrix(m: projection)
        logMatrix(m: points)
        // Variables
        let collumns = points[0].count
        let rows = points.count
        let projectionCollums = projection[0].count
        let projectionRows = projection.count
        //Dont ever skip protection. IT ISN'T SAFE
        guard rows == projectionCollums else {
            throw MatrixError.CollumnsAndRowsUnequal(collumns: collumns, rows: projectionRows)
        }
        var result = Array<Array<Int>>()
        print("-----------------Starting-Math------------------")
        for i in 0...(projectionRows-1) {
            print("projectionRows: \(projectionRows). At index: \(i)")
            for j in 0...(collumns-1) {
                print("collumns: \(collumns). At index: \(j)")
                var sum: Int = 0
                for k in 0...(rows-1) {
                    
                    sum += projection[i][k] * points[k][j]
                    /*
                    if i > projection.count {
                        print("k: \(k) is out the index range")
                        throw MatrixError.IndexOutOfRange(index: k, range: projection[i].count)
                    } else if k > projection[i].count {
                        print("i: \(i) is out the index range")
                    }
                    sum += projection[i][k] * points[k][j]
                     */
                }
                result.append([sum])
            }
        }
        print("------------------Ending-Math------------------")
        logMatrix(m: result)
        print("------------------Ending-Cast------------------")
        return result
    }
}
func logMatrix(m: Array<Array<Int>>) {
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
 4D projection to 3D
 
 */
