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
        VStack {
            if let posterPath = castItem.profilePath {
                ImageView(url: posterPath, width: 70, height: 80, opacity: 1.0, fillContentMode: true)
                    .clipped()
                    
            }
            
            Text(castItem.name)
                .font(.callout)
            
            
            Text(castItem.character)
                .font(.callout)
        }
        .foregroundStyle(.theme)
    }
    
    
    
}

#Preview {
    CastDetailsView(castItem: .example)
}
