//
//  UnsplashPhoto.swift
//  Application Unsplash
//
//  Created by Tevin DERVAUX on 1/24/24.
//

import Foundation

struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let slug: String
    let author: User?
    let urls: UnsplashPhotoUrls
}
enum CodingKeys: String, CodingKey {
        case id
        case slug
        case title
        case author = "user"
        case url = "urls"
    }
struct User: Codable {
    let name: String
}

struct UnsplashPhotoUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
