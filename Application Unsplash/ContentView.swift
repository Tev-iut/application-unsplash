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
                       await feedState.fetchHomeTopics()
                       await feedState.fetchHomeFeed()
                       
                   }
               }, label: {
                   Text("Load Data")
               })
            ScrollView {
                if (feedState.homeTopics != nil) {
                    
                    HStack() {
                            ForEach(feedState.homeTopics!, id: \.id) { topic in
                                NavigationLink(destination: TopicView(topic: topic)) {
                                    VStack{
                                        AsyncImage(url: URL(string: topic.cover_photo.urls.raw)) { image in
                                            image.centerCropped()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(height: 50).clipShape(RoundedRectangle(cornerRadius: 12))
                                        Text(topic.slug)
                                    }
                                }
                        }
                    }
                } else {
                    HStack() {
                        ForEach(1..<4) { _ in
                            RoundedRectangle(cornerRadius: 12)
                            .frame(height: 50)}
                            .foregroundColor(.gray)
                            .opacity(0.4)
                    }
                }
    
                if (feedState.homeFeed != nil) {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(feedState.homeFeed!, id: \.id) { photo in
                            NavigationLink (destination: ImageView(image: photo)) {
                                AsyncImage(url: URL(string: photo.urls.raw)!) { image in
                                    image.centerCropped().frame(height: 150).cornerRadius(10.0)
                                } placeholder: {
                                    Color.gray.frame(height: 150)
                                }
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
