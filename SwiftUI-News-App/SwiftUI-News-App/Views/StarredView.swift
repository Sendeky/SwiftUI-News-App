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
    @State var articles: [Article]
    
    var body: some View {
        ArticleListView(articles: articles)
        Text(articles[0].author)
        Button {
            ArticleListView(articles: articles)
            print("articles: \(articles)")
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
