//
//  GenreView.swift
//  MovieSearch
//
//  Created by Anna Filin on 08/12/2024.
//

import SwiftUI

struct GenreView: View {
    let genre: Genre
    
    var body: some View {
        ZStack {
                   RoundedRectangle(cornerRadius: 25)
                .fill(.shadow)

                   VStack {
                       Text(genre.name)
                           .font(.largeTitle)
//                           .foregroundStyle(.black)

                      
                   }

               }
               .frame(width: 200, height: 130)
    }
}

#Preview {
    GenreView(genre: .example)
}
