//
//  ContentView.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/10/23.
//

import SwiftUI
import SwiftyJSON
import SwiftUIInfiniteList

enum NewsTypes: String, CaseIterable, Identifiable {
    case technology, business, politics, science, health, cars, programming, entertainment, california
    var id: Self { self }
}

var articlesArray = [Article]()

struct ContentView: View {
    
    //    let tempLink = "https://tesla-cdn.thron.com/delivery/public/image/tesla/256d1141-44e7-4bd3-8fdc-20852283c645/bvlatuR/std/4096x3072/Model-X-Specs-Hero-Desktop-LHD"
    
    @ObservedObject var viewModel: InfiniteListViewModel
    //@State var articles: [Article] = [Article(author: "", title: "", description: "", url: "", urlToImage: "", published: "")]
    @State var links: [URL] //= [URL(string: "google.com")!]
    @State private var selectedCategory: NewsTypes = .technology
    @State var presentingSettings = false
    @State var presentingStarred = false
    @State var categoriesArray = ["Technology"]
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad { //iPad layout
            NavigationView {
                List {
                    NavigationLink {
                        InfiniteList(data: $viewModel.items,
                                     isLoading: $viewModel.isLoading,
                                     loadingView: ProgressView(),
                                     loadMore: viewModel.loadMore
                        ) { item in
                            ArticleRowView(article: item)
                            //SwipeActions for liking and disliking articles
                                .swipeActions(edge: .trailing) {
                                    Button { print("liked: \(item)") }
                                    label: { Image(systemName: "hand.thumbsup") }
                                    .tint(.green)
                                }
                                .swipeActions(edge: .leading) {
                                    Button { print("disliked: \(item)") }
                                    label: { Image(systemName: "hand.thumbsdown") }
                                    .tint(.red)
                                }
                        }
                    } label: {
                        Label("\(selectedCategory.rawValue)", systemImage: "laptopcomputer")
                    }
                    NavigationLink {
                        InfiniteList(data: $viewModel.items,
                                     isLoading: $viewModel.isLoading,
                                     loadingView: ProgressView(),
                                     loadMore: viewModel.loadMore
                        ) { item in
                            ArticleRowView(article: item)
                            //SwipeActions for liking and disliking articles
                                .swipeActions(edge: .trailing) {
                                    Button { print("liked: \(item)") }
                                    label: { Image(systemName: "hand.thumbsup") }
                                    .tint(.green)
                                }
                                .swipeActions(edge: .leading) {
                                    Button { print("disliked: \(item)") }
                                    label: { Image(systemName: "hand.thumbsdown") }
                                    .tint(.red)
                                }
                        }
                    } label: {
                        Label("\(NewsTypes.business.rawValue)", systemImage: "chart.line.uptrend.xyaxis")
                    }
                }
                .navigationTitle("Categories")
                InfiniteList(data: $viewModel.items,
                             isLoading: $viewModel.isLoading,
                             loadingView: ProgressView(),
                             loadMore: viewModel.loadMore
                ) { item in
                    ArticleRowView(article: item)
                    //SwipeActions for liking and disliking articles
                        .swipeActions(edge: .trailing) {
                            Button { print("liked: \(item)") }
                            label: { Image(systemName: "hand.thumbsup") }
                            .tint(.green)
                        }
                        .swipeActions(edge: .leading) {
                            Button { print("disliked: \(item)") }
                            label: { Image(systemName: "hand.thumbsdown") }
                            .tint(.red)
                        }
                }
            }
            .listStyle(PlainListStyle())
            .onAppear {
                articlesArray.append(Article(author: "", title: "Hello", description: "Welcome", url: "", urlToImage: "", published: "Now"))
                Task {
                    do {
                        let arr = try await apiCall(category: selectedCategory.rawValue)
                        print("\(arr)")
                        articlesArray.append(contentsOf: arr)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .onChange(of: selectedCategory) { value in
                Task {
                    articlesArray.removeAll()
                    //                    apiCall(category: selectedCategory.rawValue)
                    do {
                        let arr = try await apiCall(category: selectedCategory.rawValue)
                        print("\(arr)")
                        articlesArray.append(contentsOf: arr)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
        } else if UIDevice.current.userInterfaceIdiom == .phone { //iPhone layout
            NavigationView() {
                InfiniteList(data: $viewModel.items,
                             isLoading: $viewModel.isLoading,
                             loadingView: ProgressView(),
                             loadMore: viewModel.loadMore
                )
                { item in
                    ArticleRowView(article: item)
                    //SwipeActions for liking and disliking articles
                        .swipeActions(edge: .trailing) {
                            Button { print("liked: \(item)") }
                            label: { Image(systemName: "hand.thumbsup") }
                            .tint(.green)
                        }
                        .swipeActions(edge: .leading) {
                            Button { print("disliked: \(item)") }
                            label: { Image(systemName: "hand.thumbsdown") }
                            .tint(.red)
                        }
                        .listRowInsets(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))         //Edge insets for list, sets sides to 5
                }
                .listStyle(PlainListStyle())
                .frame(width: UIScreen.main.bounds.width)
                .navigationTitle("\(selectedCategory.rawValue.capitalized)")    //NavigationView title
                .navigationBarItems(trailing: settingsButton)                   //Adds settings button
//                .navigationBarItems(trailing: starredButton)
                .navigationBarItems(leading: menu)
                .frame(width: UIScreen.main.bounds.width * 1.0)                 //Makes ArticleList larger
            }
            .onAppear {
                articlesArray.append(Article(author: "aaaaaa", title: "", description: "", url: "", urlToImage: "", published: "now"))
                Task {
                    do {
                        let arr = try await apiCall(category: selectedCategory.rawValue)
                        articlesArray.append(contentsOf: arr)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .onChange(of: selectedCategory) { value in
                articlesArray.removeAll()
                articlesArray.append(Article(author: "aaaaaa", title: "", description: "", url: "", urlToImage: "", published: "now"))
                Task {
                    do {
                        let arr = try await apiCall(category: selectedCategory.rawValue)
                        articlesArray.append(contentsOf: arr)
                        //print("articlesArray \(articlesArray)")
                        self.viewModel.resetItems()
                        self.viewModel.loadMore()
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var menu: some View {
        Menu {
            Picker("Category", selection: $selectedCategory) {
                Text("\(categoriesArray[0])").tag(NewsTypes.technology)
                Text("Business").tag(NewsTypes.business)
                Text("Politics").tag(NewsTypes.politics)
                Text("Science").tag(NewsTypes.science)
                Text("Health").tag(NewsTypes.health)
                Text("Cars").tag(NewsTypes.cars)
                Text("Programming").tag(NewsTypes.programming)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(viewModel: InfiniteListViewModel(), links: [URL(string: "google.com")!])
                .preferredColorScheme(.light)
            ContentView(viewModel: InfiniteListViewModel(), links: [URL(string: "google.com")!])
                .preferredColorScheme(.dark)
        }
    }
}
