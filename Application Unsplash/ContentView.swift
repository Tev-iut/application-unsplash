//
//  ContentView.swift
//  Application Unsplash
//
//  Created by Tevin DERVAUX on 1/23/24.
//

import SwiftUI

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}

struct ContentView: View {
    @State var imageList: [UnsplashPhoto] = []
    
    func loadData() async {
        // Créez une URL avec la clé d'API
        let url = URL(string: "https://api.unsplash.com/photos?client_id=\(ConfigurationManager.instance.plistDictionnary.clientId)")!
        
        do {
            // Créez une requête avec cette URL
            let request = URLRequest(url: url)
            
            // Faites l'appel réseau
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Transformez les données en JSON
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            
            // Mettez à jour l'état de la vue
            imageList = deserializedData
            
        } catch {
            print("Error: \(error)")
        }
    }
    
    
    let columns = [
        GridItem(.adaptive(minimum: 150)),
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        
        NavigationStack {
            Button(action: {
                   Task {
                       await loadData()
                   }
               }, label: {
                   Text("Load Data")
               })
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(imageList, id: \.id) { photo in
                        AsyncImage(url: URL(string: photo.urls.full)!) { image in
                            image.centerCropped().frame(height: 150).cornerRadius(10.0)
                        } placeholder: {
                            Color.gray.frame(height: 150)
                        }
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .scenePadding(.horizontal)
            .navigationTitle("Feed")
        }
    }
        
}

#Preview {
    ContentView()
}
