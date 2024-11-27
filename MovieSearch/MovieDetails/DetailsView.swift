//
//  DetailsView.swift
//  MovieSearch
//
//  Created by Anna Filin on 26/11/2024.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var favorites: Favorites

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
                Text(formatMovieDuration(minutes: movieDetails.runtime ?? 0))
                    .font(.callout)
            }
            
            HStack(spacing: 8) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", movieDetails.vote_average))
                    Text("(\(movieDetails.vote_count))")
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
                Text(movieDetails.release_date ?? "Unknown Release Date")
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
                Text(ListFormatter.localizedString(byJoining: movieDetails.origin_country))
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
    let wickedMovie = Movie(
        id: 402431,
           title: "Wicked",
           original_title: "Wicked",
           original_language: "en",
           overview: """
               Elphaba, an ostracized but defiant girl born with green skin, and Galinda, 
               a privileged aristocrat born popular, become extremely unlikely friends 
               in the magical Land of Oz. As the two girls struggle with their opposing 
               personalities, their friendship is tested as both begin to fulfil their destinies 
               as Glinda the Good and The Wicked Witch of the West.
               """,
           poster_path: "/c5Tqxeo1UpBvnAc3csUm7j3hlQl.jpg",
           backdrop_path: "/uVlUu174iiKhsUGqnOSy46eIIMU.jpg",
           genre_ids: [18, 14, 10749],
           release_date: "2024-11-20",
           popularity: 927.236,
           vote_average: 7.5,
           vote_count: 30,
           adult: false,
           video: false
    )
    
    let details = MovieDetail(
        adult: false,
        backdrop_path: "/uVlUu174iiKhsUGqnOSy46eIIMU.jpg",
        belongs_to_collection: MovieCollection(
            id: 968080,
            name: "Wicked Collection",
            poster_path: "/b9xo966oVIrFtpevhLQ9XILcXTh.jpg",
            backdrop_path: "/xFcLusbzDM86mla4vjdEBHi7jLW.jpg"
        ),
        budget: 145000000,
        genres: [
            Genre(id: 18, name: "Drama"),
            Genre(id: 14, name: "Fantasy"),
            Genre(id: 10749, name: "Romance")
        ],
        homepage: "https://www.wickedmovie.com",
        id: 402431,
        imdb_id: "tt1262426",
        origin_country: ["US"],
        original_language: "en",
        original_title: "Wicked",
        overview: "Elphaba, a young woman misunderstood because of her green skin, and Glinda, a popular aristocrat gilded by privilege, become unlikely friends in the fantastical Land of Oz. As the two women struggle with their opposing personalities, their friendship is tested as both begin to fulfill their destinies as Glinda the Good and the Wicked Witch of the West.",
        popularity: 1334.482,
        poster_path: "/c5Tqxeo1UpBvnAc3csUm7j3hlQl.jpg",
        production_companies: [
            ProductionCompany(id: 33, logo_path: "/3wwjVpkZtnog6lSKzWDjvw2Yi00.png", name: "Universal Pictures", origin_country: "US"),
            ProductionCompany(id: 2527, logo_path: "/osO7TGmlRMistSQ5JZusPhbKUHk.png", name: "Marc Platt Productions", origin_country: "US")
        ],
        production_countries: [
            ProductionCountry(iso_3166_1: "US", name: "United States of America")
        ],
        release_date: "2024-11-20",
        revenue: 0,
        runtime: 161,
        spoken_languages: [
            SpokenLanguage(english_name: "English", iso_639_1: "en", name: "English")
        ],
        status: "Released",
        tagline: "Everyone deserves the chance to fly.",
        title: "Wicked",
        video: false,
        vote_average: 7.713,
        vote_count: 82
    )
    
    DetailsView(movieDetails: details, movie: wickedMovie)
        .environmentObject(Favorites())
}
