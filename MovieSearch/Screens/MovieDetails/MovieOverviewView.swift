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
        VStack(alignment: .leading, spacing: 8) {
               Text(overview)
                   .font(.headline)
                   .opacity(0.7)
                   .multilineTextAlignment(.leading)
                   .lineLimit(expandText ? nil : 3)
                   .frame(maxHeight: expandText ? .infinity : 60)
                   .animation(
//                       Animation.easeInOut(duration: 0.7),
                    Animation.linear(duration: 0.7),
                       value: expandText
                   )

               Button(action: {
                   withAnimation(.easeInOut(duration: 0.5)) {
                       expandText.toggle()
                   }
               }) {
                   Text(!expandText ? "More" : "Show less")
                       .font(.subheadline)
                       .fontWeight(.semibold)
                       .foregroundColor(.shadow)
                       .opacity(0.7)
               }
               .buttonStyle(.plain)
           }
    }
}

#Preview {
    MovieOverviewView(overview: "Elphaba, an ostracized but defiant girl born with green skin, and Galinda, a privileged aristocrat born popular, become extremely unlikely friends in the magical Land of Oz. As the two girls struggle with their opposing personalities, their friendship is tested as both begin to fulfill their destinies as Glinda the Good and The Wicked Witch of the West.")
}
