//
//  ArticleRowView.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/10/23.
//

import SwiftUI

let imageURL = "https://tesla-cdn.thron.com/delivery/public/image/tesla/256d1141-44e7-4bd3-8fdc-20852283c645/bvlatuR/std/4096x3072/Model-X-Specs-Hero-Desktop-LHD"

struct ArticleRowView: View {
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .failure:  //if AsyncImage fails
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: UIScreen.main.bounds.width/3)
                        Spacer()
                    }
                @unknown default:   //if unknown error happens
                    fatalError()
                }
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Headline")
                    .font(.headline)
                    .lineLimit(2)
                Text("Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiosmud ")
                    .lineLimit(2)
                    .font(.subheadline)
                HStack {
                    Text("Caption")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    
                    Button {
                        presentShareSheet(url: imageURL)
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .foregroundColor(.orange)
                    .buttonStyle(.bordered)
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width / 1.15)
        }
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRowView()
    }
}
