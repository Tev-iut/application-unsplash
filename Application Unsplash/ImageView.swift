//
//  ImageView.swift
//  Application Unsplash
//
//  Created by Tevin DERVAUX on 1/24/24.
//

import SwiftUI

struct ImageView: View {
    @State var image: UnsplashPhoto
    
    var body: some View {
        NavigationView{
            NavigationStack{
                VStack {
                    if (image.user != nil){
                        Text(image.user!.name)
                    }
                    AsyncImage(url: URL(string: image.urls.raw)!) { image in
                        image.centerCropped()
                    } placeholder: {
                        Color.gray.frame(height: 150)
                    }
                }
            }
        }

    }
}

//#Preview {
//    ImageView()
//}
