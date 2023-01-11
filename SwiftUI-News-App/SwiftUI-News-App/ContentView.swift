//
//  ContentView.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/10/23.
//

import SwiftUI


enum Flavor: String, CaseIterable, Identifiable {
    case chocolate, vanilla, strawberry
    var id: Self { self }
}


struct ContentView: View {
    
    @State private var selectedFlavor: Flavor = .chocolate
    
    var body: some View {
        NavigationView() {
            ScrollView {
                ArticleRowView()
            }
            .navigationTitle("Title")
            .navigationBarItems(trailing: menu)
        }
    }
    
    @ViewBuilder
    private var menu: some View {
        Menu {
            Picker("Category", selection: $selectedFlavor) {
                Text("Chocolate").tag(Flavor.chocolate)
                Text("Vanilla").tag(Flavor.vanilla)
                Text("Strawberry").tag(Flavor.strawberry)
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
