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
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(.theme)
                .opacity(0.6)
//            Text("\(voteCount ?? 0) reviewers")
//                .foregroundStyle(.theme)
//                .opacity(0.5)
            
            Image(systemName: "star.fill")
                .foregroundColor(.theme)
                .shadow(color: .shadow, radius: 3)
                .opacity(0.7)
        }
    }
}

#Preview {
    RatingView(voteAverage: 7.8, voteCount: 467)
}
