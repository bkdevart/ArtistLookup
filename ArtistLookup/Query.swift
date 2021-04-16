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
    static let media = ["all", "movie", "podcast", "music", "musicVideo", "audiobook",
                         "shortFilm", "tvShow", "software", "ebook"]

    @Published var key = 0
    @Published var media = 0
}
