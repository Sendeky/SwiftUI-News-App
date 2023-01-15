//
//  ArticleRowView.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/10/23.
//

import SwiftUI


struct ArticleRowView: View {
    
    @State private var state = false    //Used for star button state
    
    let article: Article
    
    var body: some View {
        VStack {
            //Asynchronously loads image from article (passed in by ArticleListView)
            AsyncImage(url: URL(string: "\(article.urlToImage)")) { status in
                switch status {
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
            //Vstack for content below image
            VStack(alignment: .leading, spacing: 10) {
                Text("\(article.title)")    //Title
                    .font(.headline)
                    .lineLimit(2)
                Text("\(article.description)")  //Description
                    .lineLimit(2)
                    .font(.subheadline)
                //Hstack for caption and buttons
                HStack {
                    Text("Caption: Lorem ipsum dolor")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    
                    //Sharebutton
                    Button {
                        presentShareSheet(url: "\(article.url)")
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .foregroundColor(.orange)
                    .buttonStyle(.bordered)
                    
                    //Starbutton
                    Button {
                        if state != true {
                            //TODO: star article
                            state = true
                        } else {
                            //TODO: unstar article
                            state = false
                        }
                    } label: {
                        //checks if star is already active =
                        if state != true {
                            Image(systemName: "star")
                        } else {
                            Image(systemName: "star.fill")
                        }
                    }
                    .foregroundColor(.orange)
                    .buttonStyle(.bordered)
                }//HStack with bottom buttons
                .padding(.vertical)
            }//Vstack with Title, Descripton, and bottom HStack
            .frame(maxWidth: UIScreen.main.bounds.width / 1.20)
        }//ArticleRowView body view
        .background(Gradient(colors: [.primary, .secondary]).opacity(0.5))
        .cornerRadius(15)
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        //        ArticleRowView(link: imageURL!)
        ArticleRowView(article: Article(author: "", title: "", description: "", url: "", urlToImage: "google.com"))
    }
}
