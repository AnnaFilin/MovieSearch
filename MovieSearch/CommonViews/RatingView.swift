//
//  RatingView.swift
//  MovieSearch
//
//  Created by Anna Filin on 03/12/2024.
//

import SwiftUI


struct RatingView: View {
    let voteAverage: Double?
    let voteCount: Int?
    
    var body: some View {
        HStack(alignment: .center) {
            Text(String(format: "%.1f", voteAverage ?? 0))
            
                .font(.caption)
                .fontWeight(.medium)
            
            Image(systemName: "star.fill")
                .foregroundColor(.gold)
        }
    }
}

#Preview {
    RatingView(voteAverage: 7.8, voteCount: 467)
}
