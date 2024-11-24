//
//  LayoutView.swift
//  MovieSearch
//
//  Created by Anna Filin on 24/11/2024.
//

import SwiftUI

struct LayoutView<Content: View>: View {
    let title: String
    let showSearch: Bool
    let content: Content
    
    init(title: String, showSearch: Bool,  @ViewBuilder content: () -> Content) {
        self.title = title
        self.showSearch = showSearch
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.16, blue: 0.12)
                .ignoresSafeArea()
            
            VStack {
                
                
                content
                    .padding()
            }
                
            

        }
        .navigationTitle(title)
    }
}

#Preview {
        LayoutView(
            title: "Movies",
            showSearch: true
        ) {
            Text("Your Content Goes Here")
                .foregroundColor(.white)
        }
}
