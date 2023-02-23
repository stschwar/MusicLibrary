//
//  MusicCollectionView.swift
//  MusicLibrary
//
//  Created by Stefan Schwarz on 22.02.23.
//

import SwiftUI
import ComposableArchitecture

struct MusicCollectionView: View {
    let musicCollectionStore: StoreOf<SearchableMusicCollectionFeature>
    
    var body: some View {
        WithViewStore(self.musicCollectionStore, observe: { $0 }) { viewStore in
            // The NavigationStack is used, even though there are
            // no actual destinations, because it provides the
            // navigation toolbar with a search field already
            // implemented.
            NavigationStack {
                VStack {
                    TabView(
                        selection: viewStore.binding(
                            get: { $0.activeTab },
                            send: { .switchTab($0) }
                        )
                    ) {
                        // Tab 1 (Albums)
                        List(
                            sortAndSearch(input: viewStore.albums,
                                          sortAscendingBy: \.album,
                                          searchFilter: { item in
                                              item.album.contains(viewStore.searchTerm) ||
                                              item.artist.contains(viewStore.searchTerm) ||
                                              !item.tracks.filter({ $0.contains(viewStore.searchTerm) }).isEmpty ||
                                              viewStore.searchTerm.isEmpty
                                          })
                        ) { item in
                            AlbumListCell(item: item)
                        }
                        .listStyle(.plain)
                        .tabItem {
                            Image(systemName: "opticaldisc")
                            Text("Albums")
                        }
                        .tag(0)
                        // Tab 2 (Artists)
                        List(
                            sortAndSearch(input: viewStore.albums,
                                          sortAscendingBy: \.artist,
                                          searchFilter: { item in
                                              item.album.contains(viewStore.searchTerm) ||
                                              item.artist.contains(viewStore.searchTerm) ||
                                              !item.tracks.filter({ $0.contains(viewStore.searchTerm) }).isEmpty ||
                                              viewStore.searchTerm.isEmpty
                                          })
                        ) { item in
                            AlbumListCell(item: item)
                        }
                        .listStyle(.plain)
                        .tabItem {
                            Image(systemName: "person.wave.2")
                            Text("Artists")
                        }
                        .tag(1)
                        // Tab 3 (Tracks)
                        List(
                            sortAndSearch(input: viewStore.tracks,
                                          sortAscendingBy: \.self,
                                          searchFilter: { item in
                                              item.contains(viewStore.searchTerm) ||
                                              viewStore.searchTerm.isEmpty
                                          }),
                            id: \.self) { item in
                            Text(item)
                        }
                        .listStyle(.plain)
                        .tabItem {
                            Image(systemName: "music.note")
                            Text("Tracks")
                        }
                        .tag(2)
                    }
                }
            }
            // This modifier helps with an issue where the List
            // content scrolls over the navigation bar
            // when changing tabs, but it doesn't solve the issue
            // entirely.
            .toolbar(.hidden, for: .navigationBar)
            .searchable(text: viewStore.binding(
                get: { $0.searchTerm },
                send: { .search($0) } )
            )
            .onAppear {
                viewStore.send(.loadAlbums)
            }
        }
    }
    
    // Applies the provided search filter to the input collection
    // and sorts the result by the provided KeyPath in ascending
    // order.
    func sortAndSearch<T>(input: [T],
                          sortAscendingBy key: KeyPath<T, String>,
                          searchFilter: (T) -> Bool) -> [T] {
        // Filter first, so you have to sort less
        return input
            .filter(searchFilter)
            .sorted(by: { $0[keyPath: key] < $1[keyPath: key] })
    }
}

struct MusicCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        MusicCollectionView(
            musicCollectionStore:
                Store(initialState: SearchableMusicCollectionFeature.State(),
                                        reducer: SearchableMusicCollectionFeature(albumFetch: { [] } )
                     )
        )
    }
}
