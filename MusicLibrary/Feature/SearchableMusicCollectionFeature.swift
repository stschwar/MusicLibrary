//
//  SortedAlbumListFeature.swift
//  MusicLibrary
//
//  Created by Stefan Schwarz on 22.02.23.
//

import Foundation
import ComposableArchitecture

struct SearchableMusicCollectionFeature: ReducerProtocol {
    
    let albumFetch: () async throws -> [MusicAlbum]
    
    struct State: Equatable {
        var albums = [MusicAlbum]()
        var tracks = [String]()
        var activeTab: Int = 0
        var searchTerm = ""
    }
    
    enum Action: Equatable {
        case switchTab(Int)
        case search(String)
        case loadAlbums
        case loadAlbumsResult(TaskResult<[MusicAlbum]>)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .switchTab(let activeTab):
            state.activeTab = activeTab
            return .none
        case .search(let searchTerm):
            state.searchTerm = searchTerm
            return .none
        case .loadAlbums:
            return .task {
                await .loadAlbumsResult(TaskResult { try await self.albumFetch() })
            }
        case .loadAlbumsResult(.success(let retrievedAlbums)):
            state.albums = retrievedAlbums
            state.tracks = retrievedAlbums.flatMap( { $0.tracks })
            return .none
        case .loadAlbumsResult(.failure(let error)):
            print("Failed to retrieve Music Albums. Error: \(error.localizedDescription)")
            state.albums = []
            state.tracks = []
            return .none
        }
    }
}
