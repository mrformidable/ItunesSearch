//
//  SongResult.swift
//  ItunesSearch
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

protocol SongType {
    var songId: Int { get }
    var songName: String { get }
    var songPreviewUrl: URL { get }
    var songPosterImageUrl: URL { get }
    var artistName: String { get }
    var genre: String { get }
}

struct SongResult: Codable {
    var songs: [Song]
}

extension SongResult {
    enum CodingKeys: String, CodingKey {
        case songs = "results"
    }
}

struct Song: Codable, SongType {
    var songId: Int
    var songName: String
    var songPreviewUrl: URL
    var songPosterImageUrl: URL
    var artistName: String
    var genre: String
}

extension Song {
    enum CodingKeys: String, CodingKey {
        case songId = "trackId"
        case songName = "trackName"
        case songPreviewUrl = "previewUrl"
        case songPosterImageUrl = "artworkUrl100"
        case artistName
        case genre = "primaryGenreName"
    }
}

extension Song: Equatable {
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.songId == rhs.songId
    }
}


