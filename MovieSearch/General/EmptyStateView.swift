//
//  EmptyStateView.swift
//  MovieSearch
//
//  Created by Anna Filin on 03/12/2024.
//

import SwiftUI

struct EmptyStateView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName:viewModel.emptyState[2] )
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            Text(viewModel.emptyState[0])
                .font(.title2)
                .fontWeight(.bold)

            Text(viewModel.emptyState[1])
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.background
        ).foregroundStyle(.white)
    }
}

#Preview {
    EmptyStateView()
        .environmentObject(ViewModel(movieService: MovieService()))
}
