//
//  PlantModelView.swift
//  Challenge 3
//
//  Created by Mustafa Topiwala on 17/11/25.
//
import SwiftUI
import Combine

class PlantModelView: ObservableObject {
    @Published var plants: [Plant] = [
        Plant(
            plantName: "Bob",
            plantType: "Orchid",
            plantIconName: "tree",
            plantAge: 1,
            daysToGerminate: 4,
            message: "Look out for sprouts",
            tips: [
                PlantTip(symbol: "sun.max", text: "Dry Environment"),
                PlantTip(symbol: "sun.haze", text: "Shield from sunlight"),
                PlantTip(symbol: "drop.fill", text: "Water Regularly"),
                PlantTip(symbol: "wind", text: "Windy area")
            ]
        )
    ]
    
    func addPlant(plant: Plant){
        plants.append(plant)
    }
    
    
}
