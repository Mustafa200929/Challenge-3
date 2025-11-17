//
//  PlantSheet.swift
//  Challenge 3
//
//  Created by Mustafa Topiwala on 17/11/25.
//
import SwiftUI

struct PlantSheet: View {
    @Binding var selectedDetent: PresentationDetent
    @EnvironmentObject var plantVM: PlantViewModel
    
    
    var body: some View {
        VStack{
            HStack{
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
            if selectedDetent == .fraction(0.7) || selectedDetent == .large{
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
                    NavigationLink{ //find a better way later
                        TipsView()
                    }label:{
                        HStack{
                            Text("Tips")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .padding(.bottom)
                                .padding(.leading)
                            Image(systemName: "chevron.right")
                                .padding(.bottom)
                        }
                        .foregroundStyle(.black)
                        .frame(maxWidth:.infinity, alignment: .leading)
                    }
                    VStack{
                        ForEach(0..<2, id: \.self){i in
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
            
        }
        .padding()
        
        Spacer()
    }
}

#Preview{
    PlantSheet(selectedDetent: .constant(.large))
        .environmentObject(PlantViewModel())
}

