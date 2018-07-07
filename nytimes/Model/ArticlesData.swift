//
//  ArticlesData.swift
//  nytimes
//
//  Created by Shantanu Khanwalkar on 07/07/18.
//  Copyright © 2018 Shantanu Khanwalkar. All rights reserved.
//

import Foundation

struct ArticlesData: Codable {
    var status: String
    var results: [Article]
}

struct Article: Codable {
    var url: String
    var section: String
    var byline: String
    var title: String
    var abstract: String
    var publishedDate: String
    var source: String
    var views: Double
    var media: [Media]
    
    enum CodingKeys: String, CodingKey {
        case url
        case section
        case byline
        case title
        case abstract
        case publishedDate = "published_date"
        case source
        case views
        case media
    }
}

struct Media: Codable {
    var type: String
    var caption: String
    var copyright: String
    var mediaMetadata: [MediaMetadata]
    
    enum CodingKeys: String, CodingKey {
        case type
        case caption
        case copyright
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadata: Codable {
    var url: String
    var format: String
    var height: Int
    var width: Int
}
