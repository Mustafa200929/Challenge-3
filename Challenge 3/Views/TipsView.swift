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
    private var model = SystemLanguageModel.default
    var body: some View {
        ZStack{
            LinearGradient(
                colors: [
                    Color(hex: "D7EEFF"),   // light sky blue
                    Color(hex: "B7D8FF"),   // soft marine
                    Color(hex: "97C1FF")    // gentle ocean blue
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0){
                Text("Tips")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .padding()
                Text("To keep your plant healthy")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
                    .padding(.bottom)
                ScrollView{
                    VStack{
                        ForEach(0..<plantVM.plants[0].tips.count, id: \.self){i in
                            HStack{
                                Image(systemName:plantVM.plants[0].tips[i].symbol)
                                    .padding()
                                    .glassEffect(.regular)
                                Text(plantVM.plants[0].tips[i].text)
                            }
                            .padding()
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .background(.black.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

#Preview{
    TipsView()
        .environmentObject(PlantViewModel())
}
