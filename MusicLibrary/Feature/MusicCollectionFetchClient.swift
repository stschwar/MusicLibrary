//
//  MusicCollectionFetchClient.swift
//  MusicLibrary
//
//  Created by Stefan Schwarz on 23.02.23.
//

import Foundation

struct MusicCollectionFetchClient {
    typealias MusicCollection = [MusicAlbum]
    
    var albumFetchUrl = URL(string: "https://1979673067.rsc.cdn77.org/music-albums.json")!
    
    func fetch() async throws -> MusicCollection {
        let (data, _) = try await URLSession.shared.data(from: self.albumFetchUrl)
        return try JSONDecoder().decode(MusicCollection.self, from: data)
    }
}
