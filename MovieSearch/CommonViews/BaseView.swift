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
//            LinearGradient(
//                gradient: Gradient(colors: [.lilac.opacity(0.4), .background.opacity(0.8), .background.opacity(0.8), .lilac.opacity(0.9)]),
//                startPoint: .top,
//                endPoint: .bottom
//            )
//            .ignoresSafeArea()
            
//            LinearGradient(
//                gradient: Gradient(colors: [.background.opacity(0.95), .eggplant.opacity(0.95), .eggplant.opacity(0.95), .background.opacity(0.95)]),
//                startPoint: .top,
//                endPoint: .bottom
//            )
//            .ignoresSafeArea()
            Color.background
                .ignoresSafeArea()
            
            VStack {
                content
                    .foregroundColor(.white)
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
