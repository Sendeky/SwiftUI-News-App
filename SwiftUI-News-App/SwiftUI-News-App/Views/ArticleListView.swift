//
//  ArticleListView.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/11/23.
//

import SwiftUI

struct ArticleListView: View {
    
    let articles: [Article]
    //    let links: [URL]
    
    var body: some View {
        List {
            ForEach(articles, id: \.self) { article in
                ArticleRowView(article: article)
                
                //Swipeable actions (like/dislike)
                    .swipeActions(edge: .trailing) {
                        Button {
                            print("liked: \(article)")
                        } label: {
                            Image(systemName: "hand.thumbsup")
                        }
                        .tint(.green)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            print("disliked: \(article)")
                        } label: {
                            Image(systemName: "hand.thumbsdown")
                        }
                        .tint(.red)
                    }
            }
        }//List
    }//Body View
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        //        ArticleListView(links: [URL(string:"google.com")!])
        ArticleListView(articles: [Article(author: "", title: "", description: "", url: "", urlToImage: "google.com")])
    }
}
