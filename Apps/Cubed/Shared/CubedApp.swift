//
//  CubedApp.swift
//  Shared
//
//  Created by The Three Monkeys on 2020-10-16.
//

import SwiftUI

@main
struct CubedApp: App {
    @Environment(\.scenePhase) private var phase
    var body: some Scene {
        WindowGroup {
            NavigationView() {
                    ContentView().environmentObject(EnvironmentClass())
            }.navigationViewStyle(DoubleColumnNavigationViewStyle())
        }.windowToolbarStyle(ExpandedWindowToolbarStyle())
        .windowStyle(HiddenTitleBarWindowStyle())
        .onChange(of: phase) { newPhase in
            switch newPhase {
            case .active:
                // active
                print("App is Active")
            case .inactive:
                // inactive
                print("App is Inactive")
            case .background:
                // background
                print("App is Backgrounded")
            @unknown default:
                //fallback
                print("The state of the app is unknown...")
            }
        }
    }
}
