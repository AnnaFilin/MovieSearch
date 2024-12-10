//
//  HorizontalScroll.swift
//  MovieSearch
//
//  Created by Anna Filin on 04/12/2024.
//
import SwiftUI


struct HorizontalScroll<Item, Content: View>: View {

    let items: [Item]
    let content: (Item) -> Content
    let horizontalInset: CGFloat

    init(items: [Item], horizontalInset: CGFloat = 16, @ViewBuilder content: @escaping (Item) -> Content) {
           self.items = items
           self.content = content
           self.horizontalInset = horizontalInset
       }


    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: AppSpacing.itemSpacing * 2) {
                ForEach(items.indices, id: \.self) { index in
                    content(items[index])
                }
            }
            .padding(.horizontal, horizontalInset)

        }
    }
}

#Preview {
    HorizontalScroll(items: [CastMember.example, CastMember.example]) { castMember in
        CastDetailsView(castItem: castMember)
    }
}
