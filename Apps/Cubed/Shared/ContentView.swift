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
            NavigationWidget()
            NavigationLink(destination: MathTestView().frame(minWidth: 400, minHeight: 400, alignment: .center)) {
                NavigationItem(title: "Meth Test", imageName: "function")
            }
            NavigationLink(destination: RenderPageView()) {
                NavigationItem(title: "Canvas View", imageName: "textbox")
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
