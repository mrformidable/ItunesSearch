//
//  State.swift
//  ItunesSearch
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

enum State {
    case finished
    case empty
    case error(NetworkError)
    case loading
    case idle
}
