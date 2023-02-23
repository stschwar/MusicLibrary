//
//  MusicLibraryApp.swift
//  MusicLibrary
//
//  Created by Stefan Schwarz on 22.02.23.
//

import SwiftUI
import ComposableArchitecture

@main
struct MusicLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            MusicCollectionView(
                musicCollectionStore:
                    Store(initialState: SearchableMusicCollectionFeature.State(),
                          reducer: SearchableMusicCollectionFeature(
                                    albumFetch: MusicCollectionFetchClient().fetch
                            ))
            )
        }
    }
}
