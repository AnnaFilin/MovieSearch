//
//  TagSection.swift
//  MovieSearch
//
//  Created by Anna Filin on 22/12/2024.
//

import SwiftUI

struct TagSection: View {
    let tags: [Genre]
    @Binding var path: [AppNavigation]
    let title: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 20, weight: .light, design: .default))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .padding(.horizontal, AppSpacing.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HorizontalScroll(items: tags, horizontalInset: AppSpacing.horizontal ) { genre in
                    GenreView(genre: genre)
                        .opacity(0.7)
                }
                .padding(.bottom, AppSpacing.vertical)
                .shadow(color: .lilac.opacity(0.2), radius: 20, x: 5, y: 10)
            }
        }
    }
}


