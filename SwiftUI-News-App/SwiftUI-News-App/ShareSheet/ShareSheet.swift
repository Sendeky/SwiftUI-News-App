//
//  ShareSheet.swift
//  SwiftUI-News-App
//
//  Created by Ruslan Spirkin on 1/18/23.
//
import SwiftUI
import Foundation


extension View {
    //MARK: makes a ShareSheet that gets called on ShareButton press (in ArticleRowView)
    func presentShareSheet(url: String) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
}
