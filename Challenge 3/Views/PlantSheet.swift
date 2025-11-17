//
//  PlantSheet.swift
//  Challenge 3
//
//  Created by Mustafa Topiwala on 17/11/25.
//
import SwiftUI

struct PlantSheet: View {
    @Binding var selectedDetent: PresentationDetent
    @StateObject var plantVM = PlantModelView()
    
    var body: some View {
        VStack{
            HStack{
                //Small bar
                Image(systemName: plantVM.plants[0].plantIconName)
                    .padding()
                    .glassEffect(.regular.tint(.teal.opacity(0.3)))
                VStack{
                    Text(plantVM.plants[0].plantName)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Text(plantVM.plants[0].plantType)
                }
                .frame(alignment: .topLeading)
                .padding()
                Spacer()
                if plantVM.plants[0].plantAge == 1{
                    Text("\(plantVM.plants[0].plantAge) day old")
                        .fontWeight(.semibold)
                }
                else{
                    Text("\(plantVM.plants[0].plantAge) days old")
                        .fontWeight(.semibold)
                }
                
            }
            .padding()
            if selectedDetent == .medium || selectedDetent == .large{
                VStack{
                    VStack{
                        Text("Should germinate in \( plantVM.plants[0].daysToGerminate) days")
                            .padding(.horizontal)
                            .padding(.top)
                            .fontWeight(.medium)
                        Text(plantVM.plants[0].message)
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
            
        }
        .padding()
        
        Spacer()
    }
}

#Preview{
    PlantSheet(selectedDetent: .constant(.medium))
}

