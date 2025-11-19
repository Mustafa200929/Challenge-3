//
//  addingplantView.swift
//  Challenge 3
//
//  Created by Adhavan senthil kumar on 15/11/25.
//

import SwiftUI

private struct ItemCenterPreferenceKey: PreferenceKey {
    static var defaultValue: [String: CGFloat] = [:]
    static func reduce(value: inout [String: CGFloat], nextValue: () -> [String: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

private func scaleForItem(containerWidth: CGFloat, itemMidX: CGFloat) -> CGFloat {
    let centerX = containerWidth / 2
    let maxDistance: CGFloat = 180
    let distance = min(abs(itemMidX - centerX), maxDistance)
    let normalized = 1 - (distance / maxDistance)
    let minScale: CGFloat = 0.9
    let maxScale: CGFloat = 1.35
    return minScale + (maxScale - minScale) * max(normalized, 0)
}

let plantIcons: [String] = [
    "plant1",
    "plant2",
    "plant3",
    "plant4",
    "plant5",
    "plant6",
    "plant7",
]
struct addingplantView: View {
    var onReturn: (() -> Void)? = nil
    @State private var selectedIcon: String? = nil
    @State private var nickname: String = ""
    @State private var selectedSpecies = "None"
    @EnvironmentObject var plantVM: PlantViewModel   // ← ADD HERE
    var onAddComplete: (() -> Void)? = nil
    @Environment(\.dismiss) private var dismiss
    let species = ["Aloe Vera",
                   "basil",
                   "Cactus",
                   "Money plant",
                   "Rubber plant",
                   "Jade plant",
                   "Spider plant",
                   "Snake plant"]
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let itemWidth: CGFloat = 140
            let itemHeight: CGFloat = 180
            let idealInset = (width - itemWidth) / 2
            let sideInset = idealInset * 0.8
            NavigationStack{
                VStack{
                    Text("Select an Icon")
                        .padding(.top)
                        .offset(x:0,y:60)
                        .bold()
                        
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 16) {
                            Spacer().frame(width: sideInset)
                            ForEach(plantIcons, id: \.self) { icon in
                                let _ = ()
                                let isSelected = (selectedIcon == icon)
                                VStack {
                                    Image(icon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                        .padding(16)
                                        .background(isSelected ? Color.accentColor.opacity(0.2) : Color.clear)
                                        .background(.thinMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(isSelected ? Color.accentColor : Color.secondary.opacity(0.2), lineWidth: isSelected ? 3 : 1)
                                        )
                                    
                                }
                                .scaleEffect(isSelected ? 1.08 : 1.0)
                                .shadow(color: isSelected ? Color.accentColor.opacity(0.25) : Color.clear, radius: isSelected ? 12 : 0, x: 0, y: 6)
                                .animation(.spring(response: 0.22, dampingFraction: 0.7), value: isSelected)
                                .frame(width: itemWidth, height: itemHeight)
                                .background(
                                    GeometryReader { itemProxy in
                                        let midX = itemProxy.frame(in: .global).midX
                                        let scale = scaleForItem(containerWidth: width, itemMidX: midX)
                                        Color.clear
                                            .preference(key: ItemCenterPreferenceKey.self, value: [icon: midX])
                                            .onChange(of: midX) { _ in }
                                            .transformEffect(.identity)
                                            .overlay(Color.clear.scaleEffect(scale))
                                    }
                                )
                                .overlay(
                                    GeometryReader { itemProxy in
                                        let midX = itemProxy.frame(in: .global).midX
                                        let s = scaleForItem(containerWidth: width, itemMidX: midX)
                                        VStack { EmptyView() }
                                            .frame(width: 0, height: 0)
                                            .onAppear {}
                                            .onChange(of: midX) { _ in }
                                            .allowsHitTesting(false)
                                            .scaleEffect(s)
                                            .animation(.spring(response: 0.35, dampingFraction: 0.8), value: s)
                                    }
                                )
                                .accessibilityLabel(Text("Icon \(icon)"))
                            }
                            Spacer().frame(width: sideInset)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 32)
                        .onPreferenceChange(ItemCenterPreferenceKey.self) { centers in
                            let centerX = width / 2
                            if let nearest = centers.min(by: { abs($0.value - centerX) < abs($1.value - centerX) })?.key {
                                if selectedIcon != nearest {
                                    withAnimation(.spring(response: 0.25, dampingFraction: 0.85)) {
                                        selectedIcon = nearest
                                    }
                                }
                            }
                        }
                    }
                    Form{
                        Section{
                            TextField("what is the nickname for your plant", text: $nickname)
                                .padding()
                                .glassEffect(.clear, in: RoundedRectangle(cornerRadius: 10))
                                .tint(.blue)
                        }
                        Section{
                            Picker("Species", selection: $selectedSpecies) {
                                ForEach(species, id: \.self) {
                                    Text($0)
                                }
                            }
                        }
                        
                    }
                    Button(action: {
                        guard let icon = selectedIcon else { return }
                        
                        let newPlant = Plant(
                            plantName: nickname,
                            plantType: selectedSpecies,
                            plantIconName: icon,
                            plantAge: 1,
                            daysToGerminate: 4,
                            message: "New Plant!",
                            tips: []
                        )
                        
                        plantVM.addPlant(plant: newPlant) // Your adonAddComplete?()
                        
                        onAddComplete?()
                        
                        
                        dismiss()
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 18, weight: .semibold))
                                .symbolRenderingMode(.hierarchical)
                            
                            Text("Add Plant")
                                .font(.system(.headline, design: .rounded))
                                .tracking(0.5)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        .background(
                            Group {
                                LinearGradient(
                                    colors: [
                                        Color.green.opacity(0.95),
                                        Color.cyan.opacity(0.95)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            }
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .strokeBorder(
                                    LinearGradient(
                                        colors: [Color.white.opacity(0.6), Color.white.opacity(0.15)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1.2
                                )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color.green.opacity(0.35), radius: 14, x: 0, y: 6)
                        .shadow(color: Color.cyan.opacity(0.25), radius: 22, x: 0, y: 12)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Add Plant")
                }.navigationTitle(Text("Add a Plant!"))
                
                
                
                
            }
        }
    }
}
#Preview {
    addingplantView()
}

