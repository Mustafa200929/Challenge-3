//
//  PlantSheet.swift
//  Challenge 3
//
//  Created by Mustafa Topiwala on 17/11/25.
//
import SwiftUI

struct PlantSheet: View {
    @Binding var selectedDetent: PresentationDetent
    @State private var plant: Plant = Plant()
    var body: some View {
        VStack{
            HStack{
                //Small bar
                plant.plantIcon
                    .padding()
                    .glassEffect(.regular.tint(.teal.opacity(0.3)))
                VStack{
                    Text(plant.plantName)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Text(plant.plantType)
                }
                .frame(alignment: .topLeading)
                .padding()
                Spacer()
                if plant.plantAge == 1{
                    Text("\(plant.plantAge) day old")
                        .fontWeight(.semibold)
                }
                else{
                    Text("\(plant.plantAge) days old")
                        .fontWeight(.semibold)
                }
                
            }
            .padding()
            if selectedDetent == .medium || selectedDetent == .large{
                VStack{
                    VStack{
                        Text("Should germinate in \( plant.daysToGerminate) days")
                            .padding(.horizontal)
                            .padding(.top)
                            .fontWeight(.medium)
                        Text(plant.message)
                            .padding(.bottom)
                    }
                    //.frame(minWidth: 350)
                    .background(.black.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    
                    Text("Germinated")
                        .padding()
                        .glassEffect(.regular.tint(Color(hex:"DFFFE9")).interactive(),in: Capsule())
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding()
                        .onTapGesture {
                            //Next page
                        }
                    Text("Tips")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.bottom)
                        .padding(.horizontal)
                    
                }
            }
            Spacer()
        }
        
    }
}

#Preview{
    PlantSheet(selectedDetent: .constant(.medium))
}
