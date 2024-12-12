//
//  ReleaseDateView.swift
//  MovieSearch
//
//  Created by Anna Filin on 03/12/2024.
//

import SwiftUI

struct ReleaseDateView: View {
    let date: String?
    
    var formattedReleaseDate: String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "yyyy"
        
        
        if let formattedDate = inputDateFormatter.date(from: date ?? "") {
            return outputDateFormatter.string(from: formattedDate)
        } else {
            return "Release date unknown"
        }
    }
    
    var body: some View {
        HStack {
            Text(formattedReleaseDate  )
                .font(.caption)
        }
        .opacity(0.8)
    }
}

#Preview {
    ReleaseDateView(date: "2015-11-10")
}
