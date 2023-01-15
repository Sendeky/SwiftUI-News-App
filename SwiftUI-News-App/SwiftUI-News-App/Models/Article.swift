//
//  Article.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/14/23.
//

import Foundation

struct Article: Codable, Hashable {
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
}

/*
 "articles": [
    {
      "source": {
        "id": "engadget",
        "name": "Engadget"
      },
      "author": "Steve Dent",
      "title": "Tesla drastically lowers EV pricing in the US and Europe",
      "description": "After steadily increasing prices over the past couple of years, Tesla has cut them drastically across its lineup in the US and Europe, in an apparent bid to boost sales. The least expensive EV, the Model 3 RWD, has dropped from $46,990 to $43,990, while the 5…",
      "url": "https://www.engadget.com/tesla-implements-huge-us-price-cuts-across-its-lineup-083211088.html",
      "urlToImage": "https://s.yimg.com/os/creatr-uploaded-images/2022-06/8bb55db0-ed48-11ec-b3fb-ba5734d864fa",
      "publishedAt": "2023-01-13T08:32:11Z",
      "content": "After steadily increasing prices over the past couple of years, Tesla has cut them drastically across its lineup in the US and Europe, in an apparent bid to boost sales. The least expensive EV, the M… [+1952 chars]"
    },
 */
