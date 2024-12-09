//
//  MovieSearchApp.swift
//  MovieSearch
//
//  Created by Anna Filin on 18/11/2024.
//

import SwiftUI

@main
struct MovieSearchApp: App {
    init() {
          setupNavigationBarAppearance()
      }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Persistence())
        }
    }

    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(Color.theme).withAlphaComponent(0.9),
            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.theme).withAlphaComponent(0.8),
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.systemGray6
           UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).layer.cornerRadius = 10
           UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).clipsToBounds = true
           UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).borderStyle = .none
        
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).transform = CGAffineTransform(scaleX: 1.0, y: 1.5)

    }
}
