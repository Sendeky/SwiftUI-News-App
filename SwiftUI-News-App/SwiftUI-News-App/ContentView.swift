//
//  ContentView.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/10/23.
//

import SwiftUI
import SwiftyJSON

enum NewsTypes: String, CaseIterable, Identifiable {
    case technology, business, politics, science, health, cars, entertainment, california
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
    @State var starredArticles: [Article]
    
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
                print("starredArticles ContentView: \(starredArticles)")
            }
            .onChange(of: selectedCategory) { value in
                Task {
                    articles.removeAll()
                    links.removeAll()
                    NewsAPICall(category: value.rawValue)
                }
                print("starredArticles ContentView: \(starredArticles)")
            }
        }
    }
    
    @ViewBuilder
    private var menu: some View {
        Menu {
            Picker("Category", selection: $selectedCategory) {
                Text("Technology").tag(NewsTypes.technology)
                Text("Business").tag(NewsTypes.business)
                Text("Politics").tag(NewsTypes.politics)
                Text("Science").tag(NewsTypes.science)
                Text("Health").tag(NewsTypes.health)
                Text("Cars").tag(NewsTypes.cars)
                Text("Entertainment").tag(NewsTypes.entertainment)
                Text("California").tag(NewsTypes.california)
            }
        } label: {
            Image(systemName: "text.justify")
                .imageScale(.large)
                .padding()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ContentView(links: [URL(string: "google.com")!])
//                .preferredColorScheme(.light)
//            ContentView(links: [URL(string: "google.com")!])
//                .preferredColorScheme(.dark)
//        }
//    }
//}
