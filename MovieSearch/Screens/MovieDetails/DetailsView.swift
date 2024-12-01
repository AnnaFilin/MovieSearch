//
//  DetailsView.swift
//  MovieSearch
//
//  Created by Anna Filin on 26/11/2024.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var favorites: Persistence

    var movieDetails: MovieDetail
    var movie: Movie
    
    var statusColor: Color {
        switch movieDetails.status.lowercased() {
        case "released": return .green
        case "upcoming": return .orange
        case "cancelled": return .red
        default: return .gray
        }
    }
    
    var formattedBudget: String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = "$"
            formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: movieDetails.budget)) ?? "$0"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(.orange)
                Text(formatMovieDuration(minutes: movieDetails.runtime))
                    .font(.callout)
            }
            
            HStack(spacing: 8) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", movieDetails.voteAverage))
                    Text("(\(movieDetails.voteCount))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                Button(action: {
                    if favorites.contains(movie) {
                        favorites.remove(movie)
                    } else {
                        favorites.add(movie)
                    }
                }) {
                    Image(systemName: favorites.contains(movie) ? "heart.fill" : "heart")
                        .foregroundColor(.orange)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .accessibilityLabel(favorites.contains(movie) ? "Remove from Favorites" : "Add to Favorites")
                }
                .padding(.horizontal, 4)
            }

            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundColor(.orange)
                Text(String(format: "%.0f", movieDetails.popularity))
                    .font(.callout)
            }
            
            HStack {
                Image(systemName: "flag")
                    .foregroundColor(statusColor)
                Text(movieDetails.status)
                    .font(.callout)

                Image(systemName: "calendar")
                    .foregroundColor(.yellow)
                Text(movieDetails.releaseDate)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            HStack {
                Image(systemName: "dollarsign.circle")
                    .foregroundColor(.orange)
                Text(formattedBudget)
                    .font(.callout)
            }
            
            HStack {
                Image(systemName: "map")
                    .foregroundColor(.orange)
                Text(ListFormatter.localizedString(byJoining: movieDetails.originCountry))
                    .font(.callout)
            }
            
            Image(systemName: movieDetails.adult ? "lock" : "smiley")
                .foregroundColor(movieDetails.adult ? .red : .yellow)
        }
    }
    
    func formatMovieDuration(minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        
        if hours > 0 {
            return "\(hours)h \(remainingMinutes)m"
        } else {
            return "\(remainingMinutes)m"
        }
    }
   
}

#Preview {
   
    DetailsView(movieDetails: .example, movie: .example)
        .environmentObject(Persistence())
}
