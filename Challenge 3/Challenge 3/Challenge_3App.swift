//
//  Challenge_3App.swift
//  Challenge 3
//
//  Created by Mustafa Topiwala on 15/11/25.
//

import SwiftUI

@main
struct Challenge_3App: App {
    @StateObject var plantVM = PlantViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(plantVM)
        }
    }
}
