//
//  ImageSliderView.swift
//  online-store
//
//  Created by Odin Grav on 04/04/2023.
//

import SwiftUI

struct ImageSliderView: View {
    // 1
    var images: Array<URL> = []
    
    var body: some View {
        // 2
        TabView {
            ForEach(images, id: \.self) { item in
                 //3
                AsyncImage(url: item) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        // Since the AsyncImagePhase enum isn't frozen,
                        // we need to add this currently unused fallback
                        // to handle any new cases that might be added
                        // in the future:
                        EmptyView()
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

