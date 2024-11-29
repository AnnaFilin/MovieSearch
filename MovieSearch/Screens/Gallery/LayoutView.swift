//
//  LayoutView.swift
//  MovieSearch
//
//  Created by Anna Filin on 24/11/2024.
//

import SwiftUI

struct LayoutView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String,  @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.16, blue: 0.12)
                .ignoresSafeArea()
            
            VStack {
                content
            }
        }
        .navigationTitle(title)
        .shadow(color: .orange, radius: 1)
    }
}

#Preview {
        LayoutView(
            title: "Movies"
        ) {
            Text("Your Content Goes Here")
                .foregroundColor(.white)
        }
        .environmentObject(Favorites())
}
