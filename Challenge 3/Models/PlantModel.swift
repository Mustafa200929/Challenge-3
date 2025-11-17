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

