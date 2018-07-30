//
//  NetworkResult.swift
//  ItunesSearch
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError: Error {
    case invalidResponse
    case invalidStatusCode(Int)
    case invalidData
    case decodingFailure(Error)
}

extension NetworkError {
    var errorDescription: String {
        switch self {
        case .invalidResponse:
            return ""
        case .invalidStatusCode:
            return "No results! Try searching for something different."
        case .invalidData:
            return "Data not valid"
        case .decodingFailure(let err):
            return "\(err)"
        }
    }
}
