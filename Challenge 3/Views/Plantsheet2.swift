//
//  PlantSheet.swift
//  Challenge 3
//
//  Created by Mustafa Topiwala on 17/11/25.
//
import SwiftUI

struct Plantsheet2: View {
    @Binding var selectedDetent: PresentationDetent
    @StateObject var plantVM = PlantViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: plantVM.plants[0].plantIconName)
                        .padding()
                        .glassEffect(.regular.tint(.teal.opacity(0.3)))

                    VStack {
                        Text(plantVM.plants[0].plantName)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Text(plantVM.plants[0].plantType)
                    }
                    .frame(alignment: .topLeading)
                    .padding()

                    Spacer()

                    if plantVM.plants[0].plantAge == 1 {
                        Text("\(plantVM.plants[0].plantAge) day old")
                            .fontWeight(.semibold)
                    } else {
                        Text("\(plantVM.plants[0].plantAge) days old")
                            .fontWeight(.semibold)
                    }
                }
                .padding()

                if selectedDetent == .medium || selectedDetent == .large {
                    VStack {
                        VStack {
                            Text("Should germinate in \(plantVM.plants[0].daysToGerminate) days")
                                .padding(.horizontal)
                                .padding(.top)
                                .fontWeight(.medium)
                            Text(plantVM.plants[0].message)
                                .padding(.bottom)
                        }
                        .background(.black.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 24))

                        Text("Germinated")
                            .padding()
                            .glassEffect(.regular.tint(Color(hex:"DFFFE9")).interactive(), in: Capsule())
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding()

                        Text("Tips")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding(.bottom)
                            .padding(.horizontal)

                        Text("Journal")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding(.bottom)
                            .padding(.horizontal)

                        NavigationLink(destination: ImageView()) {
                            VStack {
                                Image(systemName: "plus")
                                    .font(.system(size: 28, weight: .medium))
                                    .padding(.bottom, 6)

                                Text("Add Photo")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                            }
                            .frame(maxWidth: .infinity, minHeight: 140)
                            .background(Color(.systemGray5))
                            .cornerRadius(16)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal)
                    }
                }

                Spacer()
            }
            .padding()
        }
    }
}

#Preview{
    Plantsheet2(selectedDetent: .constant(.medium))
}

