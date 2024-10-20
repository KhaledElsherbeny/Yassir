//
//  CharacterList.swift
//  Saned
//
//  Created by Khalid on 03/09/2024.
//

import Foundation

struct CharacterList {
    var pagingInfo: CharacterListPageInfo?
    var characters: [CharacterListItem]?
}

extension CharacterList {
    init(response: CharacterListDTO) {
        pagingInfo = nil
        characters = response.results?.map({ CharacterListItem(response: $0) }) ?? []
    }
}

struct CharacterListPageInfo {
    var count, pages: Int?
    var next: String?
    var prev: String?
}

struct CharacterListItem {
    var id: Int
    var name: String
    var status: Status?
    var species: Species?
    var type: String?
    var gender: Gender?
    var origin, location: Location?
    var image: String?
    var episode: [String]?
    var url: String?
}

extension CharacterListItem {
    init(response: CharacterListItemDTO) {
        self.id = response.id ?? 0
        self.name = response.name ?? ""
        self.status = response.status
        self.species = response.species
        self.type = response.type
        self.gender = response.gender
        self.image = response.image
        self.url = response.url
        self.origin = response.origin
        self.location = response.location
        self.species = response.species
    }
}

