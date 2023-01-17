//
//  ContentView.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/10/23.
//

import SwiftUI
import SwiftyJSON

enum NewsTypes: String, CaseIterable, Identifiable {
    case technology, business
    var id: Self { self }
}

struct ContentView: View {
    
    
    let tempLink = "https://tesla-cdn.thron.com/delivery/public/image/tesla/256d1141-44e7-4bd3-8fdc-20852283c645/bvlatuR/std/4096x3072/Model-X-Specs-Hero-Desktop-LHD"
    //    let links = [
    //        URL(string: "https://tesla-cdn.thron.com/delivery/public/image/tesla/256d1141-44e7-4bd3-8fdc-20852283c645/bvlatuR/std/4096x3072/Model-X-Specs-Hero-Desktop-LHD")!]
    
    @State var articles: [Article] = [Article(author: "", title: "", description: "", url: "", urlToImage: "")]
    @State var links: [URL] //= [URL(string: "google.com")!]
    @State private var selectedCategory: NewsTypes = .technology
    @State var presentingSettings = false
    @State var presentingStarred = false
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad { //iPad layout
            NavigationView {
                List {
                    NavigationLink {
                        PadArticleListView(articles: articles)
                    } label: {
                        Label("\(selectedCategory.rawValue)", systemImage: "bolt.car.fill")
                    }
                    NavigationLink {
                        PadArticleListView(articles: articles)
                    } label: {
                        Label("\(NewsTypes.business.rawValue)", systemImage: "bolt.car.fill")
                    }
                }
                .navigationTitle("Categories")
                PadArticleListView(articles: articles)
            }
            .listStyle(SidebarListStyle())
            .onAppear {
                Task {
                    NewsAPICall(category: selectedCategory.rawValue)
                }
            }
            .onChange(of: selectedCategory) { value in
                Task {
                    articles.removeAll()
                    links.removeAll()
                    NewsAPICall(category: selectedCategory.rawValue)
                }
            }
        } else if UIDevice.current.userInterfaceIdiom == .phone { //iPhone layout
            NavigationView() {
                ArticleListView(articles: articles)
                    .navigationTitle("\(selectedCategory.rawValue)")
                    .navigationBarItems(trailing: settingsButton)
                    .navigationBarItems(trailing: starredButton)
                    .navigationBarItems(leading: menu)
                    .frame(width: UIScreen.main.bounds.width * 1.1)
            }
            .onAppear {
                Task {
                    NewsAPICall(category: selectedCategory.rawValue)
                }
            }
            .onChange(of: selectedCategory) { value in
                Task {
                    articles.removeAll()
                    links.removeAll()
                    NewsAPICall(category: value.rawValue)
                }
            }
        }
    }
    
    @ViewBuilder
    private var menu: some View {
        Menu {
            Picker("Category", selection: $selectedCategory) {
                Text("Technology").tag(NewsTypes.technology)
                Text("Stocks").tag(NewsTypes.business)
            }
        } label: {
            Image(systemName: "text.justify")
                .imageScale(.large)
                .padding()
        }
    }
    
    private var settingsButton: some View {
        Button { self.presentingSettings = true }
    label: {
        Image(systemName: "gear")
    }
    .sheet(isPresented: $presentingSettings) { SettingsView(settingsPresentedModal: self.$presentingSettings)}
    }
    
    private var starredButton: some View {
        Button { self.presentingStarred = true }
    label: {
        Image(systemName: "star")
    }
    .sheet(isPresented: $presentingStarred) { StarredView(starredPresentingModal: self.$presentingStarred)}
    }
    
    
    private func NewsAPICall(category: String) {
        //                let urlString = "https://newsapi.org/v2/everything?q=\(value.rawValue)&sortBy=popularity&apiKey=\(Constants.apiKey)"
//        let urlString = "https://saurav.tech/NewsAPI/top-headlines/category/\(category)/in.json" //TEMP URL FOR TESTING
        let urlString = "https://news-374821.uc.r.appspot.com/news?q=\(category)&token=\(Constants.apiKey)"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let result = JSON(data)
                
//                let status = result["status"]
//                print("Status: \(status)")
                
                for i in 0...9 {
                    let a = result[i]
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
