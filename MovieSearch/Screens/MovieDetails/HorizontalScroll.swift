//
//  HorizontalScroll.swift
//  MovieSearch
//
//  Created by Anna Filin on 04/12/2024.
//
import SwiftUI

struct HorizontalScroll: View {
   
    let cast: [CastMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 10) {
                ForEach(cast, id: \.id) { castMember in
                    VStack(alignment: .leading, spacing: 6) {
                        if let profilePath = castMember.profilePath {
                            ImageView(url: profilePath, width: 90, height: 110, opacity: 0.8, fillContentMode: true)
                                .clipped()
                                .shadow(radius: 2)
                                .cornerRadius(8)
                        }

                            Text(castMember.name)
                                .font(.callout)
                                .foregroundStyle(.theme.opacity(0.5))
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: 90, alignment: .leading)
                            
                            Text(castMember.character)
                                .font(.callout)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: 90, alignment: .leading)
                                .foregroundStyle(.theme.opacity(0.6))
                        }
                        .frame(width: 90)
                    }
                }
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            }
//        .background(.black)
        }
    }
 


#Preview {
   
     
  
    HorizontalScroll(cast: [.example])
}
