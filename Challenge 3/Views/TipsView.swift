//
//  TipsView.swift
//  Challenge 3
//
//  Created by Mustafa Topiwala on 17/11/25.
//
import SwiftUI

struct TipsView: View {
    var body: some View {
        VStack{
            Text("Tips")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview{
    TipsView()
}
