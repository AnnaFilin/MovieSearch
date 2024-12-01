//
//  LayoutView.swift
//  MovieSearch
//
//  Created by Anna Filin on 24/11/2024.
//

import SwiftUI

struct BaseView<Content: View>: View {
    
    
    let title: String
    let content: Content
    
    init(title: String,  @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack {
                content
                    .foregroundColor(.theme)
            }
        }
        .navigationTitle(title)
        .shadow(color: .shadow, radius: 1)
    }
}

#Preview {
        BaseView(
            title: "Movies"
        ) {

            MovieView(movie: .example)
        }
        .environmentObject(Persistence())
}
