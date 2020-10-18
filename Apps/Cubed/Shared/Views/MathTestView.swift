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
    }
}

struct MathTestView_Previews: PreviewProvider {
    static var previews: some View {
        MathTestView()
    }
}
