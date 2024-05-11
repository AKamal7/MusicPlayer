//
//  Song.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 20/03/2024.
//

import Foundation

struct Song {
    var id: String
    var name: String
    var artistName: String
    var artworkURL: String
    
    init(id: String, name: String, artistName: String, artworkURL: String) {
        self.id = id
        self.name = name
        self.artworkURL = artworkURL
        self.artistName = artistName
    }
}

struct Video: Codable {
    let videoId: String
    let title: String
    let thumbnailUrl: String
    let channelTitle: String
}

//
//struct RecognitionSong: Codable {
//    struct Artwork: Codable {
//        let bgColor: Int
//        let height: Int
//        let textColor1: String
//        let textColor2: String
//        let textColor3: String
//        let textColor4: String
//        let url: String
//        let width: Int
//    }
//
//    struct Preview: Codable {
//        let url: String
//    }
//
//    struct PlayParams: Codable {
//        let id: Int
//        let kind: String
//    }
//
//    let album: String
//    let appleMusic: AppleMusic
//    let artist: String
//    let label: String
//    let releaseDate: String
//    let songLink: String
//    let timecode: String
//    let title: String
//
//    enum CodingKeys: String, CodingKey {
//        case album
//        case appleMusic = "apple_music"
//        case artist
//        case label
//        case releaseDate = "release_date"
//        case songLink = "song_link"
//        case timecode
//        case title
//    }
//
//    struct AppleMusic: Codable {
//        let albumName: String
//        let artistName: String
//        let artwork: Artwork
//        let composerName: String
//        let discNumber: Int
//        let durationInMillis: Int
//        let genreNames: [String]
//        let isrc: String
//        let name: String
//        let playParams: PlayParams
//        let previews: [Preview]
//        let releaseDate: String
//        let trackNumber: Int
//        let url: String
//
//        enum CodingKeys: String, CodingKey {
//            case albumName = "albumName"
//            case artistName = "artistName"
//            case artwork = "artwork"
//            case composerName = "composerName"
//            case discNumber = "discNumber"
//            case durationInMillis = "durationInMillis"
//            case genreNames = "genreNames"
//            case isrc = "isrc"
//            case name = "name"
//            case playParams = "playParams"
//            case previews = "previews"
//            case releaseDate = "releaseDate"
//            case trackNumber = "trackNumber"
//            case url = "url"
//        }
//    }
//}
//struct MusicRecognitionResponse: Codable {
//    let requestAPIMethod: String
//    let requestHTTPMethod: String
//    let requestParams: RequestParams
//    let seeAPIDocumentation: String
//    let status: String
//}
//
//struct RequestParams: Codable {
//    let apiToken: String
//    let returnParams: String
//}
//struct SongData: Codable {
//    let result: SongResult
//    let status: String
//}
//
//struct SongResult: Codable {
//    let album: String
//    let appleMusic: AppleMusicData
//    let artist: String
//    let label: String
//    let releaseDate: String
//    let songLink: String
//    let timecode: String
//    let title: String
//
//    enum CodingKeys: String, CodingKey {
//        case album
//        case appleMusic = "apple_music"
//        case artist, label
//        case releaseDate = "release_date"
//        case songLink = "song_link"
//        case timecode, title
//    }
//}
//
//struct AppleMusicData: Codable {
//    let albumName: String
//    let artistName: String
//    let artwork: ArtworkData
//    let composerName: String
//    let discNumber: Int
//    let durationInMillis: Int
//    let genreNames: [String]
//    let isrc: String
//    let name: String
//    let playParams: PlayParamsData
//    let previews: [PreviewData]
//    let releaseDate: String
//    let trackNumber: Int
//    let url: String
//
//    enum CodingKeys: String, CodingKey {
//        case albumName = "albumName"
//        case artistName = "artistName"
//        case artwork, composerName, discNumber, durationInMillis, genreNames, isrc, name, playParams, previews, releaseDate, trackNumber, url
//    }
//}
//
//struct ArtworkData: Codable {
//    let bgColor: Int
//    let height: Int
//    let textColor1, textColor2, textColor3, textColor4: String
//    let url: String
//    let width: Int
//}
//
//struct PlayParamsData: Codable {
//    let id: String
//    let kind: String
//}
//
//struct PreviewData: Codable {
//    let url: String
//}
struct SongResponse: Codable {
    let status: String
    let result: SongResult?
}

struct SongResult: Codable {
    let artist, title, album, releaseDate, label, timecode, songLink: String?
    let apple_music: AppleMusic?
    let lyrics: Lyrics?
}

struct Lyrics: Codable {
    let song_id: String?
    let artist_id: String?
    let artist: String?
    let lyrics: String?
    let media: String?
}

struct AppleMusic: Codable {
    let previews: [Preview]
    let artwork: SongArtwork
    let artistName, url, releaseDate, name, isrc, albumName, composerName: String
    let discNumber, durationInMillis, trackNumber: Int
    let genreNames: [String]
    let playParams: SongPlayParams

    enum CodingKeys: String, CodingKey {
        case previews, artwork, artistName, url, releaseDate, name, isrc, albumName, composerName, discNumber, durationInMillis, trackNumber, genreNames, playParams
    }
}

struct Preview: Codable {
    let url: String
}

struct SongArtwork: Codable {
    let width, height: Int
    let url: String
    let bgColor, textColor1, textColor2, textColor3, textColor4: String

    enum CodingKeys: String, CodingKey {
        case width, height, url, bgColor, textColor1, textColor2, textColor3, textColor4
    }
}

struct SongPlayParams: Codable {
    let id, kind: String
}

struct Album: Codable {
    let albumType: String
    let artists: [Artist]
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls
    let href, id, name, releaseDate, releaseDatePrecision, uri: String
    let images: [Image]
    let totalTracks: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type", artists, availableMarkets, externalUrls, href, id, name, releaseDate = "release_date", releaseDatePrecision = "release_date_precision", uri, images, totalTracks, type
    }
}

struct Artist: Codable {
    let externalUrls: ExternalUrls
    let href, id, name, type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls", href, id, name, type, uri
    }
}

struct ExternalUrls: Codable {
    let spotify: String
}

struct Image: Codable {
    let height, width: Int
    let url: String
}

struct ExternalIds: Codable {
    let isrc: String
}



