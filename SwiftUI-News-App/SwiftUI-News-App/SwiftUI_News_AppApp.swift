//
//  SwiftUI_News_AppApp.swift
//  SwiftUI-News-App
//
//  Created by RuslanS on 1/10/23.
//

import SwiftUI

@main
struct SwiftUI_News_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(links: [URL(string: "google.com")!])
        }
    }
}
