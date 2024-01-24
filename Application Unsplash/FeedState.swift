//
//  FeedState.swift
//  Application Unsplash
//
//  Created by Tevin DERVAUX on 1/24/24.
//

import Foundation

class FeedState : ObservableObject {
    
    @Published var homeFeed: [UnsplashPhoto]?

    // Fetch home feed doit utiliser la fonction feedUrl de UnsplashAPI
    // Puis assigner le résultat de l'appel réseau à la variable homeFeed
    func fetchHomeFeed(orderBy: String = "popular", perPage: Int = 10, path: String = "/photos") async {
        // Récupération de l'url
        let url = URLRequest(url: UnsplashAPI.feedUrl(orderBy: orderBy, perPage: perPage, path: path)!)
        
        do {
            // Créez une requête avec cette URL
            let request = url
            
            // Faites l'appel réseau
            let (data, _) = try await URLSession.shared.data(for: request)
            
            // Transformez les données en JSON
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            
            // Mettez à jour l'état de la vue
            await MainActor.run {
                homeFeed = deserializedData
            }
            
        } catch {
            print("Error: \(error)")
        }
    }
}
