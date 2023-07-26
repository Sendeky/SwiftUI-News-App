//
//  InfiniteListViewModel.swift
//  SwiftUI-News-App
//
//  Created by Ruslan Spirkin on 1/21/23.
//
import Combine
import Foundation


class InfiniteListViewModel: ObservableObject {
    @Published var items = [Article]()
    @Published var isLoading = false
    private var lastIndex = 0
//    private var page = 1
    private var subscriptions = Set<AnyCancellable>()
    
    func resetItems() {
        self.items.removeAll()
        self.lastIndex = 0
        self.isLoading = false
    }
    
    func loadMore() {
        guard !isLoading else { return }
        if lastIndex >= articlesArray.count { return }
        
        var newIndex =  0
        var arr_tmp1 = [Article]()
        var arr_tmp2 = [Article]()
        
        if (lastIndex + 20) >= articlesArray.count { //hitting the end of articlesArray array
            arr_tmp1.append(contentsOf: articlesArray)
            newIndex = articlesArray.count
            print("loadMore - 1 - \(lastIndex) - \(articlesArray.count)")
        }
        else {  // not hitting the end yet
            arr_tmp1.append(contentsOf: articlesArray.prefix(lastIndex + 20))
            newIndex = lastIndex + 20
            print("loadMore - 2 - \(lastIndex) - \(articlesArray.count)")
        }
        
        arr_tmp2.append(contentsOf: arr_tmp1.suffix(from: lastIndex))
        
        isLoading = true
        arr_tmp2.publisher
            .map {index in Article(
                author: "\(index.author)",
                title: "\(index.title)",
                description: "\(index.description)",
                url: "\(index.url)",
                urlToImage: "\(index.urlToImage)",
                published: "\(index.published)"
            )
            }
            .collect()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .sink { [self] completion in
                isLoading = false
//                page += 1
                lastIndex = newIndex
            } receiveValue: { [self] value in
                items += value
            }
            .store(in: &subscriptions)
    }
}
