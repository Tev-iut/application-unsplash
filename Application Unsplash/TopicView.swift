//
//  TopicView.swift
//  Application Unsplash
//
//  Created by Tevin DERVAUX on 1/24/24.
//

import SwiftUI

struct TopicView: View {
    @State var topic: UnsplashTopic
    @StateObject var feedState = FeedState()
    
    let columns = [
        GridItem(.adaptive(minimum: 150)),
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView{
            NavigationStack {
                Button(action: {
                    Task {
                        await feedState.fetchHomeTopicsPhoto(orderBy: "popular", perPage: 10, slug: topic.slug)
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
            }
        }
        .navigationTitle(topic.slug)
    }
}

//#Preview {
//    TopicView(UnsplashTopic(id: 3, slug: "oe", cover_photo: <#T##CoverPhoto#>))
//}
