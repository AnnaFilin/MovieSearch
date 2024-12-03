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
        outputDateFormatter.dateFormat = "dd MMM yy"

        if let formattedDate = inputDateFormatter.date(from: date ?? "") {
            return outputDateFormatter.string(from: formattedDate)
        } else {
            return "Release date unknown"
        }
    }
    
    var body: some View {
        HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.yellow)
            Text(formattedReleaseDate  )
                    .font(.caption)
        }
    }
}

#Preview {
    ReleaseDateView(date: "2015-11-10")
}
