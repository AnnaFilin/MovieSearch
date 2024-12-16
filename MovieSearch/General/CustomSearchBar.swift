//
//  CustomSearchBar.swift
//  MovieSearch
//
//  Created by Anna Filin on 15/12/2024.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText: String
    var placeholder: String = "Search..."
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.lilac)
                .opacity(0.6)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.leading, 12)
                
                ZStack(alignment: .leading) {
                    if searchText.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 18))
                            .padding(.vertical, 10)
                            .padding(.leading, 4)
                    }
                    
                    TextField("", text: $searchText)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(.vertical, 10)
                        .padding(.leading, 4)
                }
                
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.trailing, 12)
                    }
                }
            }
            .padding(.vertical, AppSpacing.vertical)
        }
        .cornerRadius(20)
    }
}


#Preview {
    CustomSearchBar(searchText: .constant(""))
}
