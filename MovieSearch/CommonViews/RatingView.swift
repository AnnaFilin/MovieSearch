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
            Image(systemName: "star.fill")
                .foregroundColor(.shadow)
            Text(String(format: "%.1f", voteAverage ?? 0))
            Text("(\(voteCount ?? 0))")
        }
    }
}

#Preview {
    RatingView(voteAverage: 7.8, voteCount: 467)
}
