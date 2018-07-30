//
//  NetworkService.swift
//  ItunesSearch
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask(with: request.url!, completionHandler: completionHandler)
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

protocol NetworkService {
    var session: URLSessionProtocol { get set }
    func fetchData<T: Codable>(with request: URLRequest,
                               completion: @escaping (NetworkResult<T>) -> Void)
}

extension NetworkService {
    func fetchData<T: Codable>(with request: URLRequest,
                               completion: @escaping (NetworkResult<T>) -> Void) {

        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            guard (200...300) ~= httpResponse.statusCode else {
                let statusCode = httpResponse.statusCode
                completion(.failure(.invalidStatusCode(statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(json))
                }
            } catch let error { completion(.failure(.decodingFailure(error))) }
            
        }
        task.resume()
    }
}
