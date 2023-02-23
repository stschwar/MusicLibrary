//
//  MusicAlbum.swift
//  MusicLibrary
//
//  Created by Stefan Schwarz on 22.02.23.
//

import Foundation

struct MusicAlbum: Decodable, Identifiable, Equatable {
    var id: String
    var album: String
    var artist: String
    var cover: String
    var label: String
    var tracks: [String]
    var year: String
}
