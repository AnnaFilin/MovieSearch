//
//  MovieImages.swift
//  MovieSearch
//
//  Created by Anna Filin on 23/12/2024.
//

import SwiftUI

struct MovieImagesView: View {
    let images: [MovieImage]
    
    var body: some View {
        ScrollView {
            HorizontalScroll(items: images)  { image in
                ImageView(url: image.filePath, width: CGFloat(image.width)/10, height: CGFloat(image.height)/10, opacity: 1.0, fillContentMode: true)
                
            }
        }
    }
}

#Preview {
    MovieImagesView(images: [.example])
}
