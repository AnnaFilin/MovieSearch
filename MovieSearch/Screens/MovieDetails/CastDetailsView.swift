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
                ImageView(url: profilePath, width: 100, height: 130, opacity: 0.8, fillContentMode: true)
                    .clipped()
                    .shadow(radius: 2)
                    .cornerRadius(8)
            }
            
            Text(castItem.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .opacity(0.7)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 100, alignment: .leading)
            
            Text(castItem.character)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 100, alignment: .leading)
                .opacity(0.5)
        }
        .frame(width: 100)
    }
    
    
    
}

#Preview {
    CastDetailsView(castItem: .example)
}
