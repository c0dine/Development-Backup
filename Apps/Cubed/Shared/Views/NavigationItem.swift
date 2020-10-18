//
//  NavigationItem.swift
//  iOS
//
//  Created by The Three Monkeys on 2020-10-17.
//

import Foundation
import SwiftUI

struct NavigationItem: View {
    var title: String
    var imageName: String
    var body: some View {
        Label(
            title: {Text(title)},
            icon: {
                Image(systemName: imageName)
            }
        )
    }
}

struct NavigationItem_Previews: PreviewProvider {
    static var previews: some View {
        NavigationItem(title: "Pooper mcdooper", imageName: "square.fill")
    }
}
