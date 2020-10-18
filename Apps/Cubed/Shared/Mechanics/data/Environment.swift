//
//  Environment.swift
//  iOS
//
//  Created by The Three Monkeys on 2020-10-17.
//

import Foundation
import SwiftUI

class EnvironmentClass: ObservableObject {
    @Published var testsMade = UserDefaults.standard.integer(forKey: "testCount") 
}
