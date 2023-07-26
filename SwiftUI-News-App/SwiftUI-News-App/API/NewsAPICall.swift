//
//  NewsAPICall.swift
//  SwiftUI-News-App
//
//  Created by Ruslan Spirkin on 1/18/23.
//

import Foundation
import SwiftyJSON

extension ContentView {
    /*
    func NewsAPICall(category: String) {
        //                let urlString = "https://newsapi.org/v2/everything?q=\(value.rawValue)&sortBy=popularity&apiKey=\(Constants.apiKey)"
        //        let urlString = "https://news-374821.uc.r.appspot.com/news?q=\(category)&token=\(Constants.apiKey)"
        let urlString =  "https://saurav.tech/NewsAPI/top-headlines/category/\(category)/in.json"
        
        Task {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    let result = JSON(data)
                    
                    for i in 0...9 {
                        let a = result["articles"][i]
                        print("articles: \(a)")
                        let imageURL = a["urlToImage"]
                        print("url:\(imageURL)")
                        let author = a["author"]
                        let title = a["title"]
                        let description = a["description"]
                        let url = a["url"]
                        var article = Article(author: "\(author)", title: "\(title)", description: "\(description)", url: "\(url)",urlToImage: "\(imageURL)")
                        articles.append(article)
                        links.append(URL(string: "\(imageURL)")!)
                    }
                    articles.remove(at: 0)
                    //                        links.remove(at: 0)
                }
            }
        }
    }
     */
    func apiCall(category: String) async throws -> [Article] {
//        let urlString =  "https://saurav.tech/NewsAPI/top-headlines/category/technology/in.json"
        let urlString = "https://apps.sendeky.me/news/news?q=\(category)&token=\(Constants.apiKey)"
//        let urlString = "http://34.122.63.98/news/news?q=\(category)&token=\(Constants.apiKey)"
        var array = [Article]()

    //    Task {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    let result = JSON(data)
                    print("result count: \(result.count)")
                    
                    
                    for i in 0...(result.count - 1) {
                        let a = result[i]
                        print("articles: \(a)")
                        let imageURL = a["urlToImage"]
//                        print("url:\(imageURL)")
                        let author = a["author"]
                        let title = a["title"]
                        let description = a["description"]
                        let url = a["url"]
                        let published = a["publishedAt"]
                        print("published: \(published)")
                        let timeStamp = dateConverter(initialDate: "\(published)")
                        var article = Article(author: "\(author) + \(i)", title: "\(title)", description: "\(description)", url: "\(url)",urlToImage: "\(imageURL)", published: "\(timeStamp)")
                        array.append(article)
                    }
                    
                    
                    /* //FOR USE WHEN TESTING API (1st url)
                    for i in 0...(result.count - 1) {
                        let a = result["articles"][i]
                        print("articles: \(a)")
                        let imageURL = a["urlToImage"]
//                        print("url:\(imageURL)")
                        let author = a["author"]
                        let title = a["title"]
                        let description = a["description"]
                        let url = a["url"]
                        let published = a["publishedAt"]
                        print("published: \(published)")
                        let timeStamp = dateConverter(initialDate: "\(published)")
                        var article = Article(author: "\(author) + \(i)", title: "\(title)", description: "\(description)", url: "\(url)",urlToImage: "\(imageURL)", published: "\(timeStamp)")
                        array.append(article)
                    }
                     */
                     
                }
            }
        return array
    }
}
