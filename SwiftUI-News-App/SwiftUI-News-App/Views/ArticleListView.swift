//
//  ArticleListView.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/11/23.
//

import SwiftUI

struct ArticleListView: View {
    
    let links: [URL]
    
    var body: some View {
        List {
            ForEach(links, id: \.self) { link in
                ArticleRowView(link: link)
//                    .frame(width: UIScreen.main.bounds.width / 1.02)
            }
//            .frame(width: UIScreen.main.bounds.width / 1.02)
        }
//        .frame(width: UIScreen.main.bounds.width / 1.02)
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(links: [URL(string:"google.com")!])
    }
}
