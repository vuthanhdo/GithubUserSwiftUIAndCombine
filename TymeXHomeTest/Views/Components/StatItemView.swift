//
//  StatItemView.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 15/1/25.
//

import SwiftUI

/// A subview for displaying individual stat items.
struct StatItemView: View {
    let iconName: String
    let statValue: String
    let statLabel: String
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .frame(width: 50, height: 50)
                .background(Color(.secondarySystemBackground)) // Dynamic background
                .clipShape(Circle())
            Text(statValue)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary) // Adapts to light/dark mode
            Text(statLabel)
                .font(.body)
                .foregroundColor(.secondary) // Adapts to light/dark mode
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    StatItemView(iconName: "person.2.fill", statValue: "statValue", statLabel: "statLabel")
}
