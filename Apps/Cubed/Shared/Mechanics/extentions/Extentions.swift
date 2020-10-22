//
//  Extentions.swift
//  HyperGan
//
//  Created by The Three Monkeys on 2020-10-17.
//

import Foundation
import SwiftUI

// Logic Magix (Haven't even used this yet)
extension View {
    @ViewBuilder
    public func `if`<V>(_ condition: Bool, input: (Self) -> V) -> some View where V: View {
        if condition {
            input(self)
        } else {
            self
        }
    }
}
