//
//  EmptyStateView.swift
//  MovieSearch
//
//  Created by Anna Filin on 03/12/2024.
//

import SwiftUI

struct EmptyStateView: View {

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "film")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            Text("No Movies Found")
                .font(.title2)
                .fontWeight(.bold)

            Text("It looks like your list is empty. Start exploring and add your favorite movies!")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background
//            LinearGradient(
//                gradient: Gradient(colors: [.orange.opacity(0.1), .orange.opacity(0.03)]),
//                startPoint: .top,
//                endPoint: .bottom
//            )
        )
    }
}

#Preview {
    EmptyStateView()
}
