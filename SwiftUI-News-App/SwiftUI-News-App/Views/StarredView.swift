//
//  StarredView.swift
//  SwiftUI-News-App
//
//  Created by Ruslan Spirkin on 1/17/23.
//

import SwiftUI

struct StarredView: View {
    
    @State var previewPresent: Bool = true
    @Binding var starredPresentingModal: Bool
    let a: [Article] = [Article(author: "author", title: "title", description: "description", url: "url.com", urlToImage: "google.com")]
//    @Binding var articles: [Article]
    
    var body: some View {
//        ArticleRowView(article: articles)
        /*
        List {
            ForEach(articles, id: \.self) { article in
                Text(article.author)
            }
        }
         */
//        ArticleListView(articles: articles)
        Button {
//            ArticleListView(articles: $articles)
//            print("articles: \($articles)")
        } label: {
            Text("button")
        }
    }
}

//struct StarredView_Previews: PreviewProvider {
//    static var previews: some View {
//        StarredView(starredPresentingModal: self.$previewPresent)
//    }
//}
