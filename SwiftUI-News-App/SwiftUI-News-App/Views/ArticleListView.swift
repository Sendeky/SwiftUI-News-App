//
//  ArticleListView.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/11/23.
//

import SwiftUI

struct ArticleListView: View {
    
    let links: [URL] = [
        URL(string: "https://tesla-cdn.thron.com/delivery/public/image/tesla/256d1141-44e7-4bd3-8fdc-20852283c645/bvlatuR/std/4096x3072/Model-X-Specs-Hero-Desktop-LHD")!,
        URL(string: "https://www.hackingwithswift.com/img/books/quick-start/swiftui/how-to-create-views-in-a-loop-using-foreach-2~dark@2x.png")!,
        URL(string: "https://www.hackingwithswift.com/img/books/quick-start/swiftui/how-to-create-views-in-a-loop-using-foreach-1~dark@2x.png")!,
    ]
    let colors: [Color] = [.red, .green, .blue]
    
    var body: some View {
        List {
            ForEach(links, id: \.self) { link in
                Text(link.description)
            }
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView()
    }
}
