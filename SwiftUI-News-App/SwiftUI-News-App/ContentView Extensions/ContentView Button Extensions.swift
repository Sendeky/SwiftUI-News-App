//
//  ContentView Button Extensions.swift
//  SwiftUI-News-App
//
//  Created by Ruslan Spirkin on 1/18/23.
//

import Foundation
import SwiftUI

extension ContentView {
    //MARK: Creates settingsButton for ContentView
    var settingsButton: some View {
        Button { self.presentingSettings = true }   //presentingSettings is variable for triggering SettingsView presentation
    label: {
        Image(systemName: "gear")   //Button image is "gear"
    }
    .sheet(isPresented: $presentingSettings) { SettingsView(settingsPresentedModal: self.$presentingSettings)}  //presents SettingsView
    }
    
    //MARK: Creates starredButton for ContentView
    var starredButton: some View {
        Button { self.presentingStarred = true
//            print("starredButton press: \(starredArticles)")
//            print("starredButton press count: \(starredArticles.count)")
        }
    label: {
        Image(systemName: "star")   //Button image is "star"
    }
//    .sheet(isPresented: $presentingStarred) { StarredView(starredPresentingModal: self.$presentingStarred, articles: $starredArticles)}  //presents StarredView
    }
}
