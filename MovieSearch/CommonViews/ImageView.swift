//
//  ImageView.swift
//  MovieSearch
//
//  Created by Anna Filin on 24/11/2024.
//

import SwiftUI

struct ImageView: View {
    @EnvironmentObject private var favorites: Persistence

    let url: String
    let width: CGFloat?
    let height: CGFloat?
    let opacity: Double
    let fillContentMode: Bool
    
    @State private var reloadKey: UUID = UUID()
    
    var body: some View {
        
        let fullUrl = URL(string: "https://image.tmdb.org/t/p/w500\(url)")
        
        AsyncImage(url: fullUrl) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(
                        width: width ?? UIScreen.main.bounds.width,
                        height: height ?? UIScreen.main.bounds.height
                    )
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(
                        contentMode: fillContentMode ? .fill: .fit
                    )
                    .frame(
                        width: width ?? UIScreen.main.bounds.width,
                        height: height ?? UIScreen.main.bounds.height,
                        alignment: .bottom
                    )
                    .opacity(opacity)
                    .cornerRadius(AppSpacing.cornerRadius)
            case .failure:
                
                Text("Failed to load image")
                    
                    .frame(
                        width: width ?? UIScreen.main.bounds.width,
                        height: height ?? UIScreen.main.bounds.height
                    )
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(AppSpacing.cornerRadius)
                    .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                reloadKey = UUID() // Обновляем ключ для перезагрузки
                                            }
                                        }
//                    .onAppear {
//                                            logImageLoadError(for: fullUrl)
//                                        }
            @unknown default:
                Text("Unknown error")
                    .frame(
                        width: width ?? UIScreen.main.bounds.width,
                        height: height ?? UIScreen.main.bounds.height
                    )
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(AppSpacing.cornerRadius)
            }
        }
        .id(reloadKey) 
    }
    
    private func logImageLoadError(for url: URL?) {
           let errorMessage = "Image load failed for URL: \(url?.absoluteString ?? "Unknown URL")"
           print(errorMessage)
       }
}

#Preview {
    ImageView(
        url: "/c5Tqxeo1UpBvnAc3csUm7j3hlQl.jpg",
        width: 100,
        height: 150,
        opacity: 0.9,
        fillContentMode: true  
    )
    .environmentObject(Persistence())
}
