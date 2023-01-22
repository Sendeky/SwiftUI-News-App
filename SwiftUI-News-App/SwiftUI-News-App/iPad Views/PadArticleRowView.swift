//
//  ArticleRowView.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/10/23.
//

import SwiftUI
import CachedAsyncImage
import SafariServices

struct PadArticleRowView: View {
    
    @State private var showSafari = false
    @State var showSheet = false
    @State private var state = false    //Used for star button state
    let article: Article
    
    var body: some View {
        VStack {
            //Asynchronously loads image
            CachedAsyncImage(url: URL(string: "\(article.urlToImage)"), urlCache: .imageCache) { status in
                switch status {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .failure:  //if AsyncImage fails
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: UIScreen.main.bounds.width/3)
                        Spacer()
                    }
                @unknown default:   //if unknown error happens
                    fatalError()
                }
            }
            .padding()
            
            //Vstack for content below image
            VStack(alignment: .leading, spacing: 10) {
                Text("\(article.title)")    //Title
                    .font(.headline)
                    .lineLimit(2)
                Text("\(article.description)")  //Description
                    .lineLimit(2)
                    .font(.subheadline)
                
                //Bottom HStack with buttons and time caption
                HStack {
                    Text("Caption: Lorem ipsum dolor")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    //Sharebutton
                    Button(action: {
                        self.showSheet.toggle()
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .actionSheet(isPresented: $showSheet, content: { ActionSheet(title: Text("Hello"))
                    })
                    .foregroundColor(.orange)
                    .buttonStyle(.bordered)
                    
                    //Starbutton
                    Button {
                        if state != true {
                            //TODO: star article
                            state = true
                        } else {
                            //TODO: unstar article
                            state = false
                        }
                    } label: {
                        //checks if star is already active =
                        if state != true { Image(systemName: "star") }
                        else { Image(systemName: "star.fill") }
                    }
                    .foregroundColor(.orange)
                    .buttonStyle(.bordered)
                } //HStack with bottom buttons and time caption
                .padding(.vertical)
            } //VStack with Title, Description, and bottom HStack
            .frame(maxWidth: UIScreen.main.bounds.width / 1.20)
            .padding()
        }
        .background(LinearGradient(colors: [.primary, .secondary], startPoint: .top, endPoint: .bottom).opacity(0.5))   //Uses LinearGradient because of iOS 15 compatability
        .cornerRadius(15)
        .onTapGesture {
            showSafari.toggle()
        }
        .fullScreenCover(isPresented: $showSafari, content: {
            SFSafariViewWrapper(url: URL(string: article.url)!)
        })
    }
}

//struct PadArticleRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        //        ArticleRowView(link: imageURL!)
//        ArticleRowView(article: Article(author: "", title: "", description: "", url: "", urlToImage: "google.com"))
//    }
//}
