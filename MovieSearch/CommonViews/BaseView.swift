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
            LinearGradient(
                gradient: Gradient(colors: [.shadow.opacity(0.3), .background.opacity(0.8), .background.opacity(0.8), .shadow.opacity(0.9)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            LinearGradient(
                gradient: Gradient(colors: [.background.opacity(1.0), .shadow.opacity(0.1), .shadow.opacity(0.1), .background.opacity(1.0)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                content
                    .foregroundColor(.theme)
            }
        }
        .navigationTitle(title)
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
