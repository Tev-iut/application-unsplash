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
    //@State var imageList: [UnsplashPhoto] = []
    @StateObject var feedState = FeedState()
    
    let columns = [
        GridItem(.adaptive(minimum: 150)),
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            Button(action: {
                   Task {
                       await feedState.fetchHomeFeed()
                   }
               }, label: {
                   Text("Load Data")
               })
            ScrollView {
                if (feedState.homeFeed != nil) {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(feedState.homeFeed!, id: \.id) { photo in
                            AsyncImage(url: URL(string: photo.urls.raw)!) { image in
                                image.centerCropped().frame(height: 150).cornerRadius(10.0)
                            } placeholder: {
                                Color.gray.frame(height: 150)
                            }
                        }
                    }
                } else {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(0..<12) { _ in
                            RoundedRectangle(cornerRadius: 10.0)
                                .frame(height: 150)
                                .opacity(0.4)
                        }
                    }
                    .redacted(reason: .placeholder)
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
