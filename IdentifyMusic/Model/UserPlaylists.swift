//
//  UserPlaylists.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 30/4/2024.
//

import Foundation

struct PlaylistResponse: Codable {
    let data: [Playlist]
    let meta: Meta
}

struct Playlist: Codable {
    let id: String
    let type: String
    let href: String
    let attributes: PlaylistAttributes
    
}

struct PlaylistAttributes: Codable {
    let lastModifiedDate: String
    let canEdit: Bool
    let name: String
    let isPublic: Bool
    let description: PlaylistDescription?
    let artwork: Artwork?
    let hasCatalog: Bool
    let dateAdded: String
    let playParams: PlayParams
}

struct PlaylistDescription: Codable {
    let standard: String
}

struct Artwork: Codable {
    let width: Int?
    let height: Int?
    let url: String
}

struct PlayParams: Codable {
    let id: String
    let kind: String
    let isLibrary: Bool
    let globalId: String?
    let versionHash: String?
}

struct Meta: Codable {
    let total: Int
}
