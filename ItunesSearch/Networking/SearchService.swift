//
//  SearchService.swift
//  ItunesSearch
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

struct SearchService<S: Codable>: NetworkService {
    var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
}

extension SearchService {
    /// Fetches songs for an artist
    /// - Parameter query: The name of the artist for the fetch request.
    /// - Parameter completion: Returns either a successful fetch or a failed request.
    func fetchSongs(matching query: String?, completion: @escaping (NetworkResult<S>) -> Void) {
        let config = NetworkSearchConfig.artistSearch(query)
        let request = config.request
        fetchData(with: request, completion: completion)
    }
}


