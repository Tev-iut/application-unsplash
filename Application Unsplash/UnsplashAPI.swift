//
//  UnsplashAPI.swift
//  Application Unsplash
//
//  Created by Tevin DERVAUX on 1/24/24.
//

import Foundation

struct UnsplashAPI {
    
    // Construit un objet URLComponents avec la base de l'API Unsplash
    // Et un query item "client_id" avec la clé d'API retrouvé depuis PListManager
    static func unsplashApiBaseUrl() -> URLComponents {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: (ConfigurationManager.instance.plistDictionnary.clientId))
        ]
        
        return components
    }
    
    // Par défaut orderBy = "popular" et perPage = 10 -> Lisez la documentation de l'API pour comprendre les paramètres, vous pouvez aussi en ajouter d'autres si vous le souhaitez
    static func feedUrl(orderBy: String = "popular", perPage: Int = 10, path: String = "/photos") -> URL? {
        
        var baseUrl = unsplashApiBaseUrl()
        baseUrl.path = path
        baseUrl.queryItems?.append(URLQueryItem(name: "orderBy", value: orderBy))
        baseUrl.queryItems?.append(URLQueryItem(name: "perPage", value: "\(perPage)"))

        return baseUrl.url
    }
}
