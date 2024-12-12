//
//  MovieOverviewView.swift
//  MovieSearch
//
//  Created by Anna Filin on 03/12/2024.
//

import SwiftUI

struct MovieOverviewView: View {
    @State private var expandText = false
    let overview: String

    var body: some View {
        VStack(alignment: .leading, spacing: expandText ? AppSpacing.itemSpacing : 0) {
                if expandText {
                    Text(overview)
                        .font(.headline)
//                        .opacity(0.6)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .frame(maxWidth: .infinity) 
                        .animation(
                            Animation.linear(duration: 0.7),
                            value: expandText
                        )
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            expandText.toggle()
                        }
                    }) {
                        Text("Show less")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.theme)
//                            .opacity(0.7)/
                    }
                    .buttonStyle(.plain)
                } else {
                    HStack(alignment: .lastTextBaseline, spacing: AppSpacing.itemSpacing / 2) {
                        Text(overview)
                            .font(.headline)
//                            .opacity(0.6)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                            .frame(maxWidth: .infinity)
                            .animation(
                                Animation.linear(duration: 0.7),
                                value: expandText
                            )
                        
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                expandText.toggle()
                            }
                        }) {
                            Text("More")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.theme)
//                                .opacity(0.7)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
    }
}

#Preview {
    MovieOverviewView(overview: "Elphaba, an ostracized but defiant girl born with green skin, and Galinda, a privileged aristocrat born popular, become extremely unlikely friends in the magical Land of Oz. As the two girls struggle with their opposing personalities, their friendship is tested as both begin to fulfill their destinies as Glinda the Good and The Wicked Witch of the West.")
}
