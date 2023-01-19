//
//  URLCache+imageCache.swift
//  SwiftUI-News-App
//
//  Created by Ruslan Spirkin on 1/18/23.
//

import Foundation

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
