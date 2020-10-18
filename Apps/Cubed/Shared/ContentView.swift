//
//  ContentView.swift
//  Shared
//
//  Created by The Three Monkeys on 2020-10-16.
//

import SwiftUI
import Foundation
struct ContentView: View {
    @State var isActive = true
    let amount = 4
    var body: some View {
        List() {
            /*
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100))
            ], spacing: 40) {
                ForEach (0...1, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 20).frame(width: 100, height: 60)
                }
            }
             */
            NavigationWidget()
            NavigationLink(destination: MathTestView().frame(minWidth: 400, minHeight: 400, alignment: .center)) {
                NavigationItem(title: "Meth Test", imageName: "function")
            }
        }.listStyle(SidebarListStyle())
        .frame(width: 250)
        .toolbar {
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
