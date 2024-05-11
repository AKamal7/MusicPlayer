//
//  AppleMusicSong.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 07/05/2024.
//

import Foundation

struct SongModel: Codable {
    let data: [SongData]
}

struct SongData: Codable {
    let id: String
    let type: String
    let href: String
    let attributes: SongAttributes
    let relationships: SongRelationships
}

struct SongAttributes: Codable {
    let albumName: String
    let genreNames: [String]
    let trackNumber: Int
    let durationInMillis: Int
    let releaseDate: String
    let isrc: String
    let artwork: MusicArtwork
    let composerName: String
    let playParams: ApplePlayParams
    let url: String
    let discNumber: Int
    let hasLyrics: Bool
    let isAppleDigitalMaster: Bool
    let name: String
    let previews: [ApplePreview]
    let artistName: String
}

struct MusicArtwork: Codable {
    let width: Int
    let height: Int
    let url: String
    let bgColor: String
    let textColor1: String
    let textColor2: String
    let textColor3: String
    let textColor4: String
}

struct ApplePlayParams: Codable {
    let id: String
    let kind: String
}

struct ApplePreview: Codable {
    let url: String
}

struct SongRelationships: Codable {
    let artists: RelationshipData
    let albums: RelationshipData
}

struct RelationshipData: Codable {
    let href: String
    let data: [Relationship]
}

struct Relationship: Codable {
    let id: String
    let type: String
    let href: String
}
