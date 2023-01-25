//
//  ArticleRowView.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/10/23.
//

import SwiftUI
import SafariServices
import CachedAsyncImage

struct ArticleRowView: View {

    @State private var lineLimit: Int = 3      //Used to expand description if needed
    @State private var showSafari: Bool = false     //Used for showing SafariWebview
    @State private var state = false    //Used for star button state
    @State var article: Article
    
    var body: some View {
        VStack {
            //Asynchronously loads image from article (passed in by ArticleListView)
            CachedAsyncImage(url: URL(string: "\(article.urlToImage)"), urlCache: .imageCache) { status in
                switch status {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .empty:    //while image is empty
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
            //Vstack for content below image
            VStack(alignment: .leading, spacing: 10) {
                Text("\(article.title)")    //Title
                    .font(.headline)
                    .lineLimit(2)
                    .clipped()
                Text("\(article.description)")  //Description
                    .lineLimit(lineLimit)
                    .font(.subheadline)
                    .clipped()
                //Hstack for caption and buttons
                HStack {
                    Text(article.published)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    //Sharebutton
                    Button {
                        presentShareSheet(url: "\(article.url)")
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
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
                        //checks if star is already active
                        if state != true {
                            Image(systemName: "star")
                        } else {
                            Image(systemName: "star.fill")
                        }
                    }
                    .foregroundColor(.orange)
                    .buttonStyle(.bordered)
                }//HStack with bottom buttons
                .padding(.bottom)
            }//Vstack with Title, Descripton, and bottom HStack
            .frame(maxWidth: UIScreen.main.bounds.width / 1.20)
            .animation(.easeInOut(duration: 0.5), value: lineLimit) //Description expansion animation
            .onTapGesture {                                         //Expands description on tap
                if lineLimit != 6 { lineLimit = 6 }
                else { lineLimit = 2 }
            }
        }//ArticleRowView body view
        .background(LinearGradient(colors: [.primary, .secondary], startPoint: .top, endPoint: .bottom).opacity(0.5))
        .cornerRadius(15)
        .onTapGesture {
            print("tapped")
            if article.url != "" {
                showSafari.toggle()
            }
        }
        .fullScreenCover(isPresented: $showSafari, content: {       //Shows safari when showSafari is toggled
            if let url = article.url {                              //Unwraps article url
                SFSafariViewWrapper(url: URL(string: url)!)         //Shows Safari with article url
            }
        })
    }
}

//struct ArticleRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        //        ArticleRowView(link: imageURL!)
//        ArticleRowView(article: Article(author: "An interesting author", title: "An interesting Title", description: "Description: Lorem ipsum dolor lorem ipsum dolor, this is very interesting, I just need to fill this description with a bunch of text, I should actually just copy and  paste all of thi so I don't have to write it all out", url: "google.com", urlToImage: "https://tesla-cdn.thron.com/delivery/public/image/tesla/256d1141-44e7-4bd3-8fdc-20852283c645/bvlatuR/std/4096x3072/Model-X-Specs-Hero-Desktop-LHD"))
//    }
//}


