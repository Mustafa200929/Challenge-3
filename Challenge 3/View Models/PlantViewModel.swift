//
//  PlantModelView.swift
//  Challenge 3
//
//  Created by Mustafa Topiwala on 17/11/25.
//
import SwiftUI
import Combine

class PlantModelView: ObservableObject {
    @Published var plants: [Plant] = []
    
    func addPlant(plant: Plant){
        plants.append(plant)
    }
    
    
}
