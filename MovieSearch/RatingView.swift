//
//  RatingView.swift
//  MovieSearch
//
//  Created by Anna Filin on 23/11/2024.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Float

    var label = ""

    var maximumRating = 10

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow

    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    rating = Float(number)
                } label: {
                    image(for: number)
                        .foregroundStyle(number > Int(rating) ? offColor : onColor)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    func image(for number: Int) -> Image {
        if number > Int(rating) {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(6.3))
}

