//
//  TipsView.swift
//  Challenge 3
//
//  Created by Mustafa Topiwala on 17/11/25.
//

import SwiftUI
import FoundationModels

struct TipsView: View {
    @EnvironmentObject var plantVM: PlantViewModel

    @StateObject private var tipGenerator = TipGenerator()
    @State private var generatedTips: [String] = []
    @State private var loadingTips = false
    @State private var errorMessage: String? = nil

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(hex: "D7EEFF"),
                    Color(hex: "B7D8FF"),
                    Color(hex: "97C1FF")
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {

                Text("Tips")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .padding()

                Text("To keep your plant healthy")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
                    .padding(.bottom)

                ScrollView {
                    VStack(spacing: 16) {

                        if loadingTips {
                            ProgressView("Generating AI tips…")
                                .frame(maxWidth: .infinity)
                                .padding()
                        }

                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        }

                        ForEach(generatedTips, id: \.self) { tip in
                            HStack {
                                Image(systemName: "leaf.fill")
                                    .padding()
                                    .glassEffect(.regular)

                                Text(tip)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.black.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .onAppear {
            Task { await loadTips() }
        }
    }

    // MARK: - Load AI Tips (now includes AGE)
    private func loadTips() async {
        guard let plant = plantVM.plants.first else {
            errorMessage = "No plant found."
            return
        }

        guard let info = PlantDatabase.first(where: {
            $0.name.lowercased() == plant.plantType.lowercased()
        }) else {
            errorMessage = "No database entry for this plant."
            return
        }

        loadingTips = true
        errorMessage = nil
        do {
            let tips = try await tipGenerator.generateTips(
                for: info,
                plantAge: plant.plantAge,
                daysToGerminate: plant.daysToGerminate
            )
            generatedTips = tips
        } catch {
            errorMessage = "Failed to load AI tips."
        }


        loadingTips = false
    }
}

#Preview{
    TipsView()
        .environmentObject(PlantViewModel())
}

