//
//  AlbumListCell.swift
//  MusicLibrary
//
//  Created by Stefan Schwarz on 23.02.23.
//

import SwiftUI

struct AlbumListCell: View {
    let item: MusicAlbum
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: item.cover)!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 60, maxHeight: 60)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            VStack(alignment: .leading, spacing: 2) {
                Text(item.album)
                    .font(.headline)
                    .fontWeight(.medium)
                Text(item.artist)
                    .font(.caption2)
                    .foregroundColor(.gray)
                Text("\(item.year) — \(item.tracks.count) Tracks")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding(5)
            Spacer()
        }
    }
}

struct AlbumListCell_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListCell(item: MusicAlbum(id: "0", album: "The Black Parade", artist: "My Chemical Romance", cover: "https://preview-cover.com", label: "Reprise Records", tracks: [], year: "2006"))
    }
}
