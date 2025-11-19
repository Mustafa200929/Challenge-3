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
    @EnvironmentObject var journalVM: JournalViewModel
    
    var body: some View {
        ZStack{
            LinearGradient(
                    colors: [
                        Color(hex: "D7EEFF"),
                        Color(hex: "B7D8FF"),
                        Color(hex: "97C1FF")
                    ],
                    startPoint: .top, endPoint: .bottom
                )
                .opacity(selectedDetent == .large ? 1 : 0)
                .animation(.easeInOut(duration: 0.25), value: selectedDetent)
                .ignoresSafeArea()
            ScrollView{
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
                            .frame(maxWidth:.infinity)
                            .background(.black.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .padding(.horizontal)
                            
                            Text("Germinated")
                                .padding()
                                .glassEffect(.regular.tint(Color(hex:"DFFFE9")).interactive(),in: Capsule())
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                                .padding()
                                .onTapGesture {
                                    //Next page
                                }
                           
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
                    
                    if selectedDetent == .large{
                        VStack{
                            HStack{
                                NavigationLink{
                                    JournalView()
                                }label:{
                                    Text("Journal")
                                        .font(.system(size: 24, weight: .bold, design: .rounded))
                                        .padding(.bottom)
                                        .padding(.leading)
                                    Image(systemName: "chevron.right")
                                        .padding(.bottom)
                                }
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top)
                                
                            }
                            ForEach(0..<2){i in
                                HStack{
                                    VStack(spacing: 4){
                                        Circle()
                                            .fill(Color(hex: "7ED957"))
                                            .frame(width: 18, height: 18)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color(hex: "4CAF50"), lineWidth: 2)
                                                    .frame(width: 24, height:24)
                                            )
                                        
                                        RoundedRectangle(cornerRadius: 2)
                                            .fill(
                                                LinearGradient(
                                                    colors: [
                                                        Color(hex: "4CAF50"),
                                                        Color(hex: "7ED957")
                                                    ],
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                )
                                            )
                                            .frame(width: 3)
                                    }
                                    VStack(alignment: .leading){
                                        Text(journalVM.journals[0].entries[i].date, style: .date)
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundStyle(.secondary)
                                        
                                        if let note = journalVM.journals[0].entries[i].notes{
                                            Text(note)
                                                .font(.system(size: 16, weight: .regular))
                                        }
                                        if let photo = journalVM.journals[0].entries[i].photo{
                                            photo
                                                .resizable()
                                                .scaledToFit()
                                                .frame(maxHeight: 300)
                                                .clipShape(RoundedRectangle(cornerRadius: 24))
                                                .padding()
                                            
                                        }
                                    }
                                }
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                }
                
            }
            .padding(.top, -20)
        }
    }


#Preview{
    PlantSheet(selectedDetent: .constant(.large))
        .environmentObject(PlantViewModel())
        .environmentObject(JournalViewModel())
}

