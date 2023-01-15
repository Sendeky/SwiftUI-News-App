//
//  ContentView.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/10/23.
//

import SwiftUI
import SwiftyJSON

enum NewsTypes: String, CaseIterable, Identifiable {
    case Tesla, Stocks
    var id: Self { self }
}


struct ContentView: View {
    
//    let links = [
//        URL(string: "https://tesla-cdn.thron.com/delivery/public/image/tesla/256d1141-44e7-4bd3-8fdc-20852283c645/bvlatuR/std/4096x3072/Model-X-Specs-Hero-Desktop-LHD")!,
//        URL(string: "https://cdn.motor1.com/images/mgl/VPBlK/s3/tesla-model-s.jpg")!,
//        URL(string: "https://cdn.motor1.com/images/mgl/9m9p2g/s3/tesla-model-y-midnight-cherry-red.jpg")!,
//    ]
    
    @State var articles: [Article] = [Article(author: "", title: "", description: "", url: "", urlToImage: "")]
    @State var links: [URL] //= [URL(string: "google.com")!]
    @State private var selectedCategory: NewsTypes = .Tesla
    @State var presentingModal = false
    
    var body: some View {
        NavigationView() {
            ArticleListView(articles: articles)
                .navigationTitle("\(selectedCategory.rawValue)")
                .navigationBarItems(trailing: settingsMenu)
                .navigationBarItems(leading: menu)
                .frame(width: UIScreen.main.bounds.width * 1.1)
        }
        .onAppear {
            Task {
//                let urlString = "https://newsapi.org/v2/everything?q=\(value.rawValue)&sortBy=popularity&apiKey=\(Constants.apiKey)"
                let urlString = "https://saurav.tech/NewsAPI/top-headlines/category/health/in.json" //TEMP URL FOR TESTING
                
                if let url = URL(string: urlString) {
                    if let data = try? Data(contentsOf: url) {
                        let result = JSON(data)
                        
                        let status = result["status"]
                        print("Status: \(status)")
                        
                        for i in 0...5 {
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
        
        .onChange(of: selectedCategory) { value in
            Task {
                articles.removeAll()
                links.removeAll()
                let urlString = "https://saurav.tech/NewsAPI/top-headlines/category/health/in.json" //TEMP URL FOR TESTING
//                let urlString = "https://newsapi.org/v2/everything?q=\(value.rawValue)&sortBy=popularity&apiKey=\(Constants.apiKey)"
                
                if let url = URL(string: urlString) {
                    if let data = try? Data(contentsOf: url) {
                        let result = JSON(data)
                        
                        let status = result["status"]
                        print("Status: \(status)")
                        
                        for i in 0...5 {
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
                        links.remove(at: 0)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var menu: some View {
        Menu {
            Picker("Category", selection: $selectedCategory) {
                Text("Tesla").tag(NewsTypes.Tesla)
                Text("Stocks").tag(NewsTypes.Stocks)
            }
        } label: {
            Image(systemName: "text.justify")
                .imageScale(.large)
                .padding()
        }
    }
    
    private var settingsMenu: some View {
        
    Button { self.presentingModal = true }
    label: {
        Image(systemName: "gear")
    }
    .sheet(isPresented: $presentingModal) { SettingsView(presentedAsModal: self.$presentingModal)}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(links: [URL(string: "google.com")!])
                .preferredColorScheme(.light)
            ContentView(links: [URL(string: "google.com")!])
                .preferredColorScheme(.dark)
        }
    }
}

extension View {
    
    func presentShareSheet(url: String) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
    
}
