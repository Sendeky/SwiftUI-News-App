//
//  ContentView.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/10/23.
//

import SwiftUI


enum NewsTypes: String, CaseIterable, Identifiable {
    case Tech, Stocks
    var id: Self { self }
}


struct ContentView: View {
    
    let links = [
        URL(string: "https://tesla-cdn.thron.com/delivery/public/image/tesla/256d1141-44e7-4bd3-8fdc-20852283c645/bvlatuR/std/4096x3072/Model-X-Specs-Hero-Desktop-LHD")!,
        URL(string: "https://cdn.motor1.com/images/mgl/VPBlK/s3/tesla-model-s.jpg")!,
        URL(string: "https://cdn.motor1.com/images/mgl/9m9p2g/s3/tesla-model-y-midnight-cherry-red.jpg")!,
    ]
    
    @State private var selectedCategory: NewsTypes = .Tech
    @State var presentingModal = false
    
    var body: some View {
        NavigationView() {
            ArticleListView(links: links)
                .navigationTitle("\(selectedCategory.rawValue)")
                .navigationBarItems(trailing: settingsMenu)
                .navigationBarItems(leading: menu)
                .frame(width: UIScreen.main.bounds.width * 1.1)
        }
    }
    
    @ViewBuilder
    private var menu: some View {
        Menu {
            Picker("Category", selection: $selectedCategory) {
                Text("Tech").tag(NewsTypes.Tech)
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
        //    label: {
        //            Image(systemName: "gear")
        //        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
            ContentView()
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
