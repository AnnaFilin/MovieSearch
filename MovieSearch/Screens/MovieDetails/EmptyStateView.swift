//
//  EmptyStateView.swift
//  MovieSearch
//
//  Created by Anna Filin on 03/12/2024.
//

import SwiftUI

struct EmptyStateView: View {
//    @Binding var selectedTab: Int // Bind the selected tab index

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "film")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
//                .foregroundColor(.orange.opacity(0.7))

            Text("No Movies Found")
                .font(.title2)
                .fontWeight(.bold)
//                .foregroundColor(.primary)

            Text("It looks like your list is empty. Start exploring and add your favorite movies!")
                .font(.subheadline)
//                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

//            Button(action: {
//                selectedTab = 0 
//            }) {
//                Text("Browse Trending Movies")
//                    .font(.headline)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.orange)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.orange.opacity(0.1), .orange.opacity(0.03)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

#Preview {
    EmptyStateView() //selectedTab: .constant(2)
}
