//
//  MovieSearchApp.swift
//  MovieSearch
//
//  Created by Anna Filin on 18/11/2024.
//

import SwiftUI

@main
struct MovieSearchApp: App {
    @StateObject private var persistence = Persistence()
    
    init() {
        setupNavigationBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Persistence())
                .environmentObject(ViewModel(movieService: MovieService()))
                .environment(\.font, .custom("SFProDisplay-Regular", size: 16))
        }
    }
    
    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        

        appearance.titleTextAttributes = [
                .foregroundColor: UIColor(Color.theme).withAlphaComponent(0.9),
                .font: UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24, weight: .bold)
            ]
            
            appearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor(Color.theme).withAlphaComponent(0.8),
                .font: UIFont(name: "SFProDisplay-Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .bold)
            ]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [
            .font: UIFont(name: "SFProDisplay-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
        ]
 
        
        
    }
}
