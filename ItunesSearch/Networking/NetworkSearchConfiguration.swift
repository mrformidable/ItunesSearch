//
//  NetworkSearchConfiguration.swift
//  ItunesSearch
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

protocol NetworkEndpoint {
    var baseUrl: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension NetworkEndpoint {
    var urlCompnents: URLComponents {
        var components = URLComponents(string: baseUrl)!
        components.path = path
        components.queryItems = queryItems
        return components
    }
    
    var request: URLRequest {
        return URLRequest(url: urlCompnents.url!)
    }
}

enum NetworkSearchConfig {
    case artistSearch(String?)
}

extension NetworkSearchConfig: NetworkEndpoint {
    var baseUrl: String {
        return "https://itunes.apple.com"
    }
    
    var path: String {
        return "/search"
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .artistSearch(let artist):
            return [URLQueryItem(name: QueryParameterKeys.media.rawValue, value: QueryValueKeys.music.rawValue),
                    URLQueryItem(name: QueryParameterKeys.entity.rawValue, value: QueryValueKeys.song.rawValue),
                    URLQueryItem(name: QueryParameterKeys.term.rawValue, value: artist)]
        }
    }
}

extension NetworkSearchConfig {
    private enum QueryParameterKeys: String {
        case media = "media"
        case entity = "entity"
        case term = "term"
    }
    
    private enum QueryValueKeys: String {
        case music = "music"
        case song = "song"
    }
}
