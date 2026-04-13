//
//  BackButton.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 15/1/25.
//

import SwiftUI

/// A reusable back button for navigation.
struct BackButton: View {
    let dismissAction: DismissAction
    
    var body: some View {
        Button(action: {
            dismissAction()
        }) {
            HStack {
                Image(systemName: "arrow.backward")
                    .foregroundStyle(Color.primary) // Adapts to light/dark mode
            }
            .foregroundColor(.blue)
        }
    }
}

#Preview {
    @Previewable @Environment(\.dismiss) var dismiss
    BackButton(dismissAction: dismiss)
}
