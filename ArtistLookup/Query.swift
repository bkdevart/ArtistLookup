//
//  Query.swift
//  ArtistLookup
//
//  Created by Brandon Knox on 4/15/21.
//

import Foundation

class Query: ObservableObject {
    static let keys = ["term", "country", "media", "entity", "attribute", "callback",
                      "limit", "lang", "version", "explicit"]
    static let entities = ["movie", "podcast", "music", "musicVideo", "audiobook",
                         "shortFilm", "tvShow", "software", "ebook", "all"]
    static let attributes = ["movie", "podcast", "music", "musicVideo", "audiobook",
                             "shortFilm", "software", "tvShow", "all"]
    @Published var key = 0
}
