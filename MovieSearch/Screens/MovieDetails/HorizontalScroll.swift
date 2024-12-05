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
            HStack(alignment: .top, spacing: AppSpacing.itemSpacing*2) {
                ForEach(cast, id: \.id) { castMember in
                    VStack(alignment: .leading, spacing: 6) {
                        if let profilePath = castMember.profilePath {
                            ImageView(url: profilePath, width: 100, height: 130, opacity: 0.8, fillContentMode: true)
                                .clipped()
                                .shadow(radius: 2)
                                .cornerRadius(8)
                        }
                        
                        Text(castMember.name)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .opacity(0.7)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: 100, alignment: .leading)
                        
                        Text(castMember.character)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: 100, alignment: .leading)
                            .opacity(0.5)
                    }
                    .frame(width: 100)
                }
            }
            .padding(.vertical, 6)
        }
    }
}



#Preview {
   
     
  
    HorizontalScroll(cast: [.example])
}
