//
//  CharacterListDTO.swift
//  Saned
//
//  Created by Khalid on 03/09/2024.
//

import Foundation

struct CharacterListDTO: Codable {
    let info: CharacterListPageInfoDTO?
    let results: [CharacterListItemDTO]?
}

struct CharacterListPageInfoDTO: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

struct CharacterListItemDTO: Codable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: Species?
    let type: String?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

struct Location: Codable {
    let name: String?
    let url: String?
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
