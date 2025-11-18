//
//  JournalView.swift
//  Challenge 3
//
//  Created by Mustafa Topiwala on 18/11/25.
//
import SwiftUI

struct JournalView: View {
    @EnvironmentObject var journalVM: JournalViewModel
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
            ScrollView{
                Text("Journal")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ForEach(0..<journalVM.journals[0].entries.count){i in
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


#Preview{
    JournalView()
        .environmentObject(JournalViewModel())
}
