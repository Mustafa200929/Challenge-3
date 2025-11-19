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
                        .offset(x:-35,y:-310)
                    Text("You check your supplies, you realise you only have one seed inside .To continue, please get a seed from your preferred plant vendor")
                        .foregroundColor(.black)
                        .offset(x:-50,y:-310)
                        .frame(width:250, height:130)
                }
                HStack {
                        
                    
                    NavigationLink(destination: addingplantView()) {
                        Image(systemName: "plus")
                            .padding()
                            .accessibilityLabel("Add Plant")
                            .glassEffect(.clear)
                            .padding()
                            
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
                
                ZStack{
                    RoundedRectangle(cornerRadius: 180)
                        .fill(Color(hex: "F2E0C2"))
                        .frame(width: 380, height: 440)
                    RoundedRectangle(cornerRadius: 180)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(hex:"E8C58C"), Color(hex: "D7B179")]),
                                startPoint:.leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: 340, height: 400)
                        .shadow(color: Color.black.opacity(0.2), radius: 10)
                    Image(systemName: "tree")
                        .padding()
                        .glassEffect(.regular.tint(.teal.opacity(0.2)).interactive())
                        .onTapGesture {
                            showSheet = true
                        }
                        .sheet(isPresented: $showSheet){
                            NavigationStack{ 
                                PlantSheet(selectedDetent: $selectedDetent)
                                    .presentationDetents([.fraction(0.1),.fraction(0.7),.large], selection: $selectedDetent)
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

