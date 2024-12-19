//
//  CastDetailsView.swift
//  MovieSearch
//
//  Created by Anna Filin on 03/12/2024.
//

import SwiftUI


struct CastDetailsView: View {
    
    var castItem: CastMember
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let profilePath = castItem.profilePath {
                ImageView(
                    url: profilePath,
                          width: 100,
                          height: 130,
                          opacity: 0.8,
                    fillContentMode: true
                )
                    .clipped()
                    .shadow(radius: 2)
                    .cornerRadius(AppSpacing.cornerRadius)
            }
            
            Text(castItem.name)
                .lineSpacing(0)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 100, alignment: .leading)
            
            Text(castItem.character)
                .lineSpacing(0)
                .font(.subheadline)
                .fontWeight(.light)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 100, alignment: .leading)
        }
        .frame(width: 100)
    }
}

#Preview {
    CastDetailsView(castItem: .example)
}
