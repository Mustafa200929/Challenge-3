//
//  PlantModal.swift
//  Challenge 3
//
//  Created by Mustafa Topiwala on 17/11/25.
//

import Foundation

struct Plant: Identifiable {
    var id = UUID()
    var plantName: String
    var plantType: String
    var plantIconName: String
    var plantAge: Int
    var daysToGerminate: Int
    var message: String
    var tips: [PlantTip]
}

struct PlantTip: Identifiable {
    var id = UUID()
    var symbol: String
    var text: String
}
/*
 struct Plant: Identifiable {
 var id = UUID()
 var plantName: String = "Bob"
 var plantType: String = "Orchid"
 var plantIcon: Image = Image(systemName: "tree")
 var plantAge: Int = 1
 var daysToGerminate: Int = 4
 var message: String = "Look out for sprouts"
 var tips: [Any] = [[Image(systemName: "sun.max"),"Dry Environment"], [Image(systemName: "sun.haze"), "Shield from sunlight"], [Image(systemName: "drop.fill"),"Water Regularly"], [Image(systemName: "wind.fill"),"Windy area"]]
 }
 */
