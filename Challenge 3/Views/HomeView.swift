//
//  HomeView.swift
//  Challenge 3
//
//  Created by Mustafa Topiwala on 16/11/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showSheet = false
    @State private var showSecondSheet = false
    
    @State private var selectedDetent: PresentationDetent =
        .fraction(0.1)
    
    @State private var boxOpacity: Double = 1
    
    @State private var selectedPlant: Plant? = nil
    @State private var showAddPlantSheet = false
    @EnvironmentObject var plantVM: PlantViewModel
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "2F66E9"),
                        Color(hex: "1C3A86"),
                        Color(hex: "122E5F")
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 20))
                        .frame(width:300, height:130)
                        .offset(x:-35, y:-310)
                    
                    Text("You check your supplies, you realise you only have one seed inside. To continue, please get a seed from your preferred plant vendor")
                        .foregroundColor(.black)
                        .frame(width:250, height:130)
                        .offset(x:-50, y:-310)
                }
                .opacity(boxOpacity)
                .animation(.easeOut(duration: 1), value: boxOpacity)
                
                
                HStack {
                    
                    
                    NavigationLink(
                        destination: addingplantView(onReturn: {
                            withAnimation(.easeOut(duration: 1.0)) {
                                boxOpacity = 0
                            }
                        })
                    ) {
                        
                        NavigationLink(destination: addingplantView()) {
                            
                            
                            Image(systemName: "plus")
                                .padding()
                                .accessibilityLabel("Add Plant")
                                .glassEffect()
                                .padding()
                        }
                        
                        
                        
                       
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                VStack{
                    Circle()
                        .fill(Color.white)
                        .frame(width:350, height: 350)
                        .blur(radius: 60)
                        .opacity(0.22)
                        .ignoresSafeArea()
                        .offset(y: -260)
                    Spacer()
                }
                .allowsHitTesting(false)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 180)
                        .fill(Color(hex: "F2E0C2"))
                        .frame(width: 380, height: 440)
                    RoundedRectangle(cornerRadius: 180)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(hex: "E8C58C"), Color(hex: "D7B179")]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: 340, height: 400)
                        .shadow(color: Color.black.opacity(0.2), radius: 10)
                    
                    // all plants grid
                    if !plantVM.plants.isEmpty {
                        let columns = [
                            GridItem(.flexible(), spacing: 8),
                            GridItem(.flexible(), spacing: 8)
                        ]
                        LazyVGrid(columns: columns, spacing: 8) {
                            // Temporary filter to hide sample "bob" plant
                            ForEach(plantVM.plants.filter { !$0.plantName.lowercased().contains("bob") }) { plant in
                                VStack(spacing: 6) {
                                    Image(plant.plantIconName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 64, height: 64)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                        .shadow(radius: 3)
                                        .onTapGesture {
                                            selectedPlant = plant
                                            showSheet = true
                                        }
                                    Text(plant.plantName)
                                        .font(.subheadline)
                                        .foregroundStyle(.primary)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.8)
                                }
                                .padding(4)
                            }
                        }
                        .padding(.horizontal, 16)
                        .frame(width: 340, height: 400)
                        .clipped()
                    }
                }
                .sheet(isPresented: $showSheet) {
                    NavigationStack {
                        PlantSheet(selectedDetent: $selectedDetent)
                            .presentationDetents([.fraction(0.1), .fraction(0.7), .large], selection: $selectedDetent)
                    }
                }
                .sheet(isPresented: $showAddPlantSheet) {
                    NavigationStack {
                        addingplantView()
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Close") { showAddPlantSheet = false }
                                }
                            }
                    }
                }
                
                VStack {
                    Spacer()
                    Text("Click on plant")
                        .padding()
                        .foregroundStyle(.white)
                        .glassEffect(.clear)
                        .padding(.bottom, 24) // add some breathing room
                }
                
            }
        }
    }
    
    
}

#Preview{
    HomeView()
        .environmentObject(PlantViewModel())
        .environmentObject(JournalViewModel())
}

