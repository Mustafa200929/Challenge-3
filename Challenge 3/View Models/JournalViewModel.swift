//
//  JournalVM.swift
//  Challenge 3
//
//  Created by Mustafa Topiwala on 18/11/25.
//
import Foundation
import Combine
import SwiftUI

class JournalViewModel: ObservableObject {
    @Published var journals: [Journal] = [
        Journal(plantID: UUID(),
                entries: [
                    JournalEntry(date: Date(), notes:"First day here!"),
                    JournalEntry(date: Date(), notes: "Yayy first seedling!", photo: Image("cactus"))
                ]
               )
    ]
    
    
}
